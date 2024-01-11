Return-Path: <linux-kernel+bounces-23607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DA182AEFE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC218282FD1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C447A15E8B;
	Thu, 11 Jan 2024 12:53:48 +0000 (UTC)
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C6715AF6;
	Thu, 11 Jan 2024 12:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 5FEEA2F2025C; Thu, 11 Jan 2024 12:53:36 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id 4E64C2F20251;
	Thu, 11 Jan 2024 12:53:34 +0000 (UTC)
From: kovalev@altlinux.org
To: harshit.m.mogalapalli@oracle.com
Cc: arnd@arndb.de,
	bryantan@vmware.com,
	darren.kenny@oracle.com,
	error27@gmail.com,
	gregkh@linuxfoundation.org,
	gustavoars@kernel.org,
	keescook@chromium.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pv-drivers@vmware.com,
	syzkaller@googlegroups.com,
	vdasa@vmware.com,
	vegard.nossum@oracle.com,
	kovalev@altlinux.org,
	nickel@altlinux.org,
	oficerovas@altlinux.org,
	dutyrok@altlinux.org
Subject: Re: [PATCH v2 2/2] VMCI: Fix memcpy() run-time warning in dg_dispatch_as_host()
Date: Thu, 11 Jan 2024 15:53:30 +0300
Message-Id: <20240111125330.53853-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
In-Reply-To: <20240105164001.2129796-2-harshit.m.mogalapalli@oracle.com>
References: <20240105164001.2129796-2-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello, I was also working on solving this problem
https://lore.kernel.org/lkml/20240110104042.31865-1-kovalev@altlinux.org/T/#t.

Please note that there are 2 such places in the code, and by analogy with your
version of the changes, including changes in the approach to calculating the
size of the allocated memory, additional changes on top of your changes will
be as follows:

diff --git a/drivers/misc/vmw_vmci/vmci_datagram.c b/drivers/misc/vmw_vmci/vmci_datagram.c
index ba379cd6d054bd..1a50fcea681bf8 100644
--- a/drivers/misc/vmw_vmci/vmci_datagram.c
+++ b/drivers/misc/vmw_vmci/vmci_datagram.c
@@ -369,8 +369,9 @@ int vmci_datagram_invoke_guest_handler(struct vmci_datagram *dg)
        if (dst_entry->run_delayed) {
                struct delayed_datagram_info *dg_info;
 
-               dg_info = kmalloc(sizeof(*dg_info) + (size_t)dg->payload_size,
+               dg_info = kmalloc(struct_size(dg_info, msg_payload, dg->payload_size),
                                  GFP_ATOMIC);
+
                if (!dg_info) {
                        vmci_resource_put(resource);
                        return VMCI_ERROR_NO_MEM;
@@ -378,7 +379,9 @@ int vmci_datagram_invoke_guest_handler(struct vmci_datagram *dg)
 
                dg_info->in_dg_host_queue = false;
                dg_info->entry = dst_entry;
-               memcpy(&dg_info->msg, dg, VMCI_DG_SIZE(dg));
+               dg_info->msg = *dg;
+               memcpy(&dg_info->msg_payload, dg + 1, dg->payload_size);
+
 
                INIT_WORK(&dg_info->work, dg_delayed_dispatch);
                schedule_work(&dg_info->work);

