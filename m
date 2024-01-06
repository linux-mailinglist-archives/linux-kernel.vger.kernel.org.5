Return-Path: <linux-kernel+bounces-18541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E096825EF7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 09:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59F1D1C231D0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 08:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569C95666;
	Sat,  6 Jan 2024 08:54:34 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail115-79.sinamail.sina.com.cn (mail115-79.sinamail.sina.com.cn [218.30.115.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A7C523F
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 08:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.71.254])
	by sina.com (10.75.12.45) with ESMTP
	id 65991535000053A2; Sat, 6 Jan 2024 16:54:21 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 73732131458000
X-SMAIL-UIID: 708C57B39F3247B4A02A0CF645A356FD-20240106-165421-1
From: Hillf Danton <hdanton@sina.com>
To: Wesley Cheng <quic_wcheng@quicinc.com>
Cc: gregkh@linuxfoundation.org,
	tiwai@suse.com,
	robh+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH v12 00/41] Introduce QC USB SND audio offloading support
Date: Sat,  6 Jan 2024 16:54:03 +0800
Message-Id: <20240106085403.3076-1-hdanton@sina.com>
In-Reply-To: <20240102214549.22498-1-quic_wcheng@quicinc.com>
References: <20240102214549.22498-1-quic_wcheng@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2 Jan 2024 13:45:08 -0800 Wesley Cheng <quic_wcheng@quicinc.com>
> Changes in v2:
> 
> XHCI:
> - Replaced XHCI and HCD changes with Mathias' XHCI interrupter changes
> in his tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git/log/?h=feature_interrupters
> 
> Adjustments made to Mathias' changes:
>   - Created xhci-intr.h to export/expose interrupter APIs versus exposing xhci.h.
>     Moved dependent structures to this file as well. (so clients can parse out
>     information from "struct xhci_interrupter")
>   - Added some basic locking when requesting interrupters.
>   - Fixed up some sanity checks.
>   - Removed clearing of the ERSTBA during freeing of the interrupter. (pending
>     issue where SMMU fault occurs if DMA addr returned is 64b - TODO)
> 
> - Clean up pending events in the XHCI secondary interrupter.  While testing USB
> bus suspend, it was seen that on bus resume, the xHCI HC would run into a command
> timeout.
> - Added offloading APIs to xHCI to fetch transfer and event ring information.
> 
> ASoC:
> - Modified soc-usb to allow for multiple USB port additions.  For this to work,
> the USB offload driver has to have a reference to the USB backend by adding
> a "usb-soc-be" DT entry to the device saved into XHCI sysdev.

Could you tip point to where the usb-soc-be DT entry is added?

> - Created separate dt-bindings for defining USB_RX port.
> - Increased APR timeout to accommodate the situation where the AFE port start
> command could be delayed due to having to issue a USB bus resume while
> handling the QMI stream start command.

