Return-Path: <linux-kernel+bounces-100440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3793E879799
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8FB82848CA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CD07C6D6;
	Tue, 12 Mar 2024 15:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b78phves"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D4FF4FA;
	Tue, 12 Mar 2024 15:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710257555; cv=none; b=BIHabCJG2KUSKVuxc4oDWahOC/fo6ctllVGkiJSy6ETMd+KMONevYZgW8r6O4EnHdIBVLqf928laW0Od8ZhtGnQoF0IA8ArKwtpQ5m7JIte1nRbWWC13w8Vcu+IYJcwilbF/nPwWPgzoKHyPHglDpLNPF+CHoTpV4WYnvy9qbY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710257555; c=relaxed/simple;
	bh=B699QGzqbXGKmn7SCx9L3vDjnq6OqBfZza3oOdqYJNU=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=hiYfMQZmY72ZjIdFYF1SozTgz/xSundkC+r+1dWdqrjFqEdnE4gNEyi5so1irXf57jHp5hSXBvTFTToM5Pra5rCUaoxB4QbWp5MyRPM0NUJU632k7Wna/62VX9qgd4TUYGZYIZT8f0SeYJ8XiyXrjRYxPAerlqDFCCJBG8hoQeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b78phves; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86242C433C7;
	Tue, 12 Mar 2024 15:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710257555;
	bh=B699QGzqbXGKmn7SCx9L3vDjnq6OqBfZza3oOdqYJNU=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=b78phvese5WkORrMEAdhLdcw3mIJkLLDnhOEjrrVmXijBl0xr/2M0zq+Q5uxPnZzh
	 HiQI1cF7qYRN4gtHpLyIij87ik+RMD5x6rfW3k5p4nZwCfBcA6LCg1Y4fdkqUmXpwy
	 omlAX26md23Dwed1LOIvKaVbsNPjkEbLc2ODA+FkQen4yfY9gje7Az3cZjix49VbPn
	 0PGh8sKG7A0DTvDvubdvYBwx4i3BIxEYstWK9GZoBycpEnoZa0HAqxNkBknDIVEdlI
	 7aH8ovhcoTA5+wY3HMrYopzo6GS+E1rTTpkVrpneiKZ70hvSMdtc0FrEsDUR1NsNcI
	 rVHaGRImE4atA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: brcmfmac: pcie: handle randbuf allocation
 failure
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240306140437.18177-1-duoming@zju.edu.cn>
References: <20240306140437.18177-1-duoming@zju.edu.cn>
To: Duoming Zhou <duoming@zju.edu.cn>
Cc: linux-kernel@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
 brcm80211@lists.linux.dev, linux-wireless@vger.kernel.org,
 minipli@grsecurity.net, hdegoede@redhat.com, arend.vanspriel@broadcom.com,
 arnd@arndb.de, Duoming Zhou <duoming@zju.edu.cn>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171025755133.1969294.16879379450612075833.kvalo@kernel.org>
Date: Tue, 12 Mar 2024 15:32:33 +0000 (UTC)

Duoming Zhou <duoming@zju.edu.cn> wrote:

> The kzalloc() in brcmf_pcie_download_fw_nvram() will return null
> if the physical memory has run out. As a result, if we use
> get_random_bytes() to generate random bytes in the randbuf, the
> null pointer dereference bug will happen.
> 
> In order to prevent allocation failure, this patch adds a separate
> function using buffer on kernel stack to generate random bytes in
> the randbuf, which could prevent the kernel stack from overflow.
> 
> Fixes: 91918ce88d9f ("wifi: brcmfmac: pcie: Provide a buffer of random bytes to the device")
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>

Patch applied to wireless-next.git, thanks.

316f790ebcf9 wifi: brcmfmac: pcie: handle randbuf allocation failure

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240306140437.18177-1-duoming@zju.edu.cn/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


