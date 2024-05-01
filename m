Return-Path: <linux-kernel+bounces-165663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D43638B8F34
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 19:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48AA5283641
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26BF13BC0E;
	Wed,  1 May 2024 17:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvHbspfh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2509C8495;
	Wed,  1 May 2024 17:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714585806; cv=none; b=JjdLgaUeMV6dxH4c56syWz1l6kbMiWw6f1Kp+QjXhAPV0hePrBV6519ElqDlvZKVERxHgOD8VLqKIPQoxUGdQqGGkb1nPt/S68AfJ0VhWWN8EUJTcZUqXKUiyW060MvM5qzRPxWE4xLG1Aj3ywV2QXXaIKJrfZZ78y2iGw+C6Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714585806; c=relaxed/simple;
	bh=0EfiIpBtBr+YNfU8vUQr6lF5Q/I+R3DuRMpwVvzyS1U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=f+Y3hsIb+BAWjzqG3q3RThkTqszDiE2iLDWvBKCybpGOe6vA8ogh8S+EMBjYOxcs6whxR/1kJoJ1WN6soWXPSPqowmkr0ko/tWCuQlNjjMyP6nmRMqcYIJLnd+9BkruMHhfnTtrX3RNW1vzCvyZhHGfsUhJ4HInySJV3nTRAfxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UvHbspfh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26DF4C072AA;
	Wed,  1 May 2024 17:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714585805;
	bh=0EfiIpBtBr+YNfU8vUQr6lF5Q/I+R3DuRMpwVvzyS1U=;
	h=Date:From:To:Cc:Subject:From;
	b=UvHbspfhwkjrYE8ShOvmOjDearA7qNJ62V8tFnnD5d1M4r6ixWfEhLqWPxKp585Jm
	 x1e/1tgQmNBMwDHBOGmeaR6Slwm5dDpL4EJzmf8nv7hmBBmBF/H1hchgd6NqjpNCLF
	 k69IJdkM+XQx0sSFEFjPe8jXQW8cGsOgy/LEZwiyZXA2ng3EVWgq/XCl/8adThmRgz
	 QP5y35+Fo7ulvTlCklQBL9Ek1g8iHgtYZVCtAFWFfABESNV2YaoXBJ2WfEjipZ7IdB
	 A5mb7Tfvuwr2+OIqC48b4TXUTBueg6dqsyhA2N7hgzbqi93JDZ9C7dwZMFSvXJMYy8
	 zRiok0vPJOvCA==
Date: Wed, 1 May 2024 11:50:02 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] Bluetooth: hci_sync: Use cmd->num_cis instead of magic
 number
Message-ID: <ZjKAyg2bZNyTcT+C@neat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

At the moment of the check, `cmd->num_cis` holds the value of 0x1f,
which is the max number of elements in the `cmd->cis[]` array at
declaration, which is 0x1f.

So, avoid using 0x1f directly, and instead use `cmd->num_cis`. Similarly
to this other patch[1].

Link: https://lore.kernel.org/linux-hardening/ZivaHUQyDDK9fXEk@neat/ [1]
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 net/bluetooth/hci_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 6e15594d3565..af9513f3c451 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6559,7 +6559,7 @@ int hci_le_create_cis_sync(struct hci_dev *hdev)
 		cis->cis_handle = cpu_to_le16(conn->handle);
 		aux_num_cis++;
 
-		if (aux_num_cis >= 0x1f)
+		if (aux_num_cis >= cmd->num_cis)
 			break;
 	}
 	cmd->num_cis = aux_num_cis;
-- 
2.34.1


