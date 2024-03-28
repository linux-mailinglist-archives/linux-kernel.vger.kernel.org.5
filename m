Return-Path: <linux-kernel+bounces-122914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6685788FF60
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0855C299B52
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473D77FBC0;
	Thu, 28 Mar 2024 12:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="QLgCbDzj"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7179C7FBB2;
	Thu, 28 Mar 2024 12:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711629672; cv=none; b=rlYrl0QXe12l8+bgByjwIvJ96Amkf+q4CBpL1pIGCwXmbGV2r2ySnRo4ZTcvF1lQeEmaEBv6LTyygv8xSc6vyX+TxPT7BsEeNaveofcRvgWJM7KM0Kq70cho/3Hm2cq/ruahTeUwzOG5KY5F5E2/EVlCXScnKToLyk0aygUxbqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711629672; c=relaxed/simple;
	bh=Jn6wq+9Xr3mn74xd/q0Un6JHaY21LvNhXdbrx6wuhUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PbHGSbnz+UFvm96L9YZs64FK+7AZey0ELPaNjdVYrcQ5rUHg+hDeqiI748j2U73o7W1M6b6e1UHF0YthtO/U3EOU5wyhWXs53F/LGjhnYdKWu02r3DIK++EnmulFTs6ujLwNEgjEuTY5IT3bPOOLbHCOEzT0zsMly2Hjp44zhxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=QLgCbDzj; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.20] (pd9e59192.dip0.t-ipconnect.de [217.229.145.146])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id C90FE2FC0063;
	Thu, 28 Mar 2024 13:41:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1711629662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6siALVMfEPEJpNoLpevoBQw2RtVVAom0abFD3I1ypZI=;
	b=QLgCbDzjyhUPH/aw0w7bNV6J6yyJyVQETrdChkN7IGiq6QsQrBTeytp3fCHJLAf4QSvtgR
	Bl/nmyvWaUthWcZsd4kLOmcmhYCv6ME1XxnVJp//s5XY7yHSpwer3QSRV6IuqboUuUisn5
	Zmsxj6mLJ97C739Fc1fLMxkfXViFSRU=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <9c32995c-e73e-416d-958d-f9960ad24686@tuxedocomputers.com>
Date: Thu, 28 Mar 2024 13:41:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ALSA: hda/realtek - Fix inactive headset mic jack
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Christoffer Sandberg <cs@tuxedo.de>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240328102757.50310-1-wse@tuxedocomputers.com>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <20240328102757.50310-1-wse@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

Forgot to add cc stable

@Takashi can you do that on merge?

Kind Regards,

Werner

Am 28.03.24 um 11:27 schrieb Werner Sembach:
> From: Christoffer Sandberg <cs@tuxedo.de>
>
> This patch adds the existing fixup to certain TF platforms implementing
> the ALC274 codec with a headset jack. It fixes/activates the inactive
> microphone of the headset.
>
> Signed-off-by: Christoffer Sandberg <cs@tuxedo.de>
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> ---
>   sound/pci/hda/patch_realtek.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index a1facdb98d9a0..3b75934ee62c1 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -10365,6 +10365,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
>   	SND_PCI_QUIRK(0x1d05, 0x1147, "TongFang GMxTGxx", ALC269_FIXUP_NO_SHUTUP),
>   	SND_PCI_QUIRK(0x1d05, 0x115c, "TongFang GMxTGxx", ALC269_FIXUP_NO_SHUTUP),
>   	SND_PCI_QUIRK(0x1d05, 0x121b, "TongFang GMxAGxx", ALC269_FIXUP_NO_SHUTUP),
> +	SND_PCI_QUIRK(0x1d05, 0x1387, "TongFang GMxIXxx", ALC2XX_FIXUP_HEADSET_MIC),
>   	SND_PCI_QUIRK(0x1d72, 0x1602, "RedmiBook", ALC255_FIXUP_XIAOMI_HEADSET_MIC),
>   	SND_PCI_QUIRK(0x1d72, 0x1701, "XiaomiNotebook Pro", ALC298_FIXUP_DELL1_MIC_NO_PRESENCE),
>   	SND_PCI_QUIRK(0x1d72, 0x1901, "RedmiBook 14", ALC256_FIXUP_ASUS_HEADSET_MIC),

