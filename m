Return-Path: <linux-kernel+bounces-59924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E9B84FD62
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 952DD1C21B16
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1091272B5;
	Fri,  9 Feb 2024 20:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z38MwJEg"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A788612C
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 20:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707509800; cv=none; b=CJPs/51dz8LLLrbgcNMBf9E8impzIbYi+wCujtW1xQlobb0Z0Igmxx1V15RC6uyW8HKgnoRC/xzNS5khQT9eEcWqJLimRIlw2S8xSUNoXWo2WRe2++0up2yxxfMb+596g7e9upoBn7WeyW/TrRaE0CMJWgjma3f+Cw9XCmJk9NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707509800; c=relaxed/simple;
	bh=kVX4vQ4ByZEK9lh6nk6RWEYTTVXDqlDXFXWRV0Lw+c0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fJRuhvMUyCbbO7KU7jJJgCXOodI60doXLPl+4x3/Udc+xsjzHz5710BXSpdWYtZX7HY5sR5+x9+zyJkdbBiHMoF8GPhU/cNCROvGSigWY/jE/Nieqcky8/C58/6I/ceGCFlmiyD93CiQQ4rWhA4jS29frJdDBSvM1ap2cij2pn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z38MwJEg; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6049e8a54b5so13811317b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 12:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707509797; x=1708114597; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NMpzWA/NvlGypXxAfQsKW8uPREZkDEVfe5vKTEeu3qY=;
        b=Z38MwJEgcdyxWz/PmALdJeJAAZaPV+jrfLr9MEchPVwKGzdhtAPYqleMjBwcl7MIpj
         F3XbuA3Jt8ZK9B6G2kzEhLDT5J6ji1NWKrfVFEhG2J6b0phODukicK3mqqanw/nfLopU
         RDzpcN1jCB180SNTXQrSS3rT7BigGROdY2n4LyqObfHFLKp7UPBkI1c4LwVLwm36zZcR
         pJkE+dZQOSkeLCRMO56GWXMCCp+jH8ZPJllSanxEkgSfVZCTfLwXuNKh2qRg+NHuCHDh
         HxhNHQBnU6qFGpPiQmmy/8k+mqHxWfpCQDCZLGnynE4vI7oyT0FBWQbxZB337lERq4ep
         YHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707509797; x=1708114597;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NMpzWA/NvlGypXxAfQsKW8uPREZkDEVfe5vKTEeu3qY=;
        b=i0IlnlceLuWVZKVL9GcK14HxUpaGn1eM5pD8ryHyDm9fqWLswd51caR60oHXhxFApv
         VkxzEZXL9tdrreTP8lGe35J1jhC4osD9Um29impOaYKcTM+5KF+FvC5kd/LrWqulh1bG
         bqp+7xpKQTcAH95AwtzSn+2VappBOU1c+hgW95ltCoh5ZCDKlFOdfqCWWasPrzi4yt3E
         s1krauB/YwdcXtFIr/EzTMzdFAOxY23dULG7AMg/gRu5HdgWuSJdCYH/HuyoLzngTK2H
         1VNS7zo7yvbmwsHlXZX/A8T5a57/53m0BGm0nOw7sc7xfW1T5+9fGqqeX3hpAtljbzo4
         3+tA==
X-Gm-Message-State: AOJu0YxjQpFSoFxpE7cP5Y8jHni//xhG6RzF8dTVUNMl1lG5CuAtZH+R
	bOLBjam3SQ+mTmxNJrJSAhpEXh9IPbavW8ViedlvvFMtexpY+Wiihcgg5Zn7Plz4PDyFIffDgaM
	bBRjvoDOg9S2HxXWCChyO4HOtoZvbehYt5LAi4g==
X-Google-Smtp-Source: AGHT+IEKs6QoPthIdR1JNmTIvNwWvSxQEoXZqRSu0xxDwQDoaITRfhzg8TinZ7IIkOZB6XA8OusWVQbCSnmA58n4RFk=
X-Received: by 2002:a81:8354:0:b0:5ff:42f2:ef75 with SMTP id
 t81-20020a818354000000b005ff42f2ef75mr364164ywf.16.1707509796998; Fri, 09 Feb
 2024 12:16:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129-ufs-core-reset-fix-v1-0-7ac628aa735f@linaro.org>
 <20240129-ufs-core-reset-fix-v1-3-7ac628aa735f@linaro.org>
 <CAA8EJpphzwoCaetGfnM8dE478ic1-BMqXKA3XVLeC9j5BBu3SA@mail.gmail.com> <20240130065550.GF32821@thinkpad>
In-Reply-To: <20240130065550.GF32821@thinkpad>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 9 Feb 2024 22:16:25 +0200
Message-ID: <CAA8EJpqZYp0C8rT8E=LoVo9fispLNhBn8CEgx1-iMqN_2MQXfg@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: msm8996: Add missing UFS host
 controller reset
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
	Bart Van Assche <bvanassche@acm.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andy Gross <agross@kernel.org>, Andy Gross <andy.gross@linaro.org>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jan 2024 at 08:55, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Mon, Jan 29, 2024 at 11:44:15AM +0200, Dmitry Baryshkov wrote:
> > On Mon, 29 Jan 2024 at 09:55, Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > >
> > > UFS host controller reset is required for the drivers to properly reset the
> > > controller. Hence, add it.
> > >
> > > Fixes: 57fc67ef0d35 ("arm64: dts: qcom: msm8996: Add ufs related nodes")
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >
> > I think I had issues previously when I attempted to reset the
> > controller, but it might be because of the incomplete clocks
> > programming. Let met check whether it works first.
> >
>
> Sure. Please let me know.

With the clocking fixes in place (I'll send them in a few minutes) and
with this patch the UFS breaks in the following way:


[    4.397919] scsi host0: ufshcd
[    4.413964] qcom-qmp-ufs-phy 627000.phy: phy initialization timed-out
[    4.415776] phy phy-627000.phy.3: phy poweron failed --> -110
[    4.419511] ufshcd-qcom 624000.ufshc: ufs_qcom_power_up_sequence:
phy power on failed, ret = -110
[    4.431297] mmc0: SDHCI controller on 74a4900.mmc [74a4900.mmc]
using ADMA 64-bit
[    4.484677] ufshcd-qcom 624000.ufshc: Controller enable failed
[    4.499710] qcom-qmp-ufs-phy 627000.phy: phy initialization timed-out
[    4.501507] phy phy-627000.phy.3: phy poweron failed --> -110
[    4.505219] ufshcd-qcom 624000.ufshc: ufs_qcom_power_up_sequence:
phy power on failed, ret = -110
[    4.570505] ufshcd-qcom 624000.ufshc: Controller enable failed
[    4.585232] qcom-qmp-ufs-phy 627000.phy: phy initialization timed-out
[    4.587296] phy phy-627000.phy.3: phy poweron failed --> -110
[    4.590733] ufshcd-qcom 624000.ufshc: ufs_qcom_power_up_sequence:
phy power on failed, ret = -110
[    4.598942] mmc0: new ultra high speed SDR104 SDHC card at address 5048
[    4.606103] mmcblk0: mmc0:5048 SD32G 28.8 GiB
[    4.615871]  mmcblk0: p1
[    4.656006] ufshcd-qcom 624000.ufshc: Controller enable failed
[    4.670985] qcom-qmp-ufs-phy 627000.phy: phy initialization timed-out
[    4.672795] phy phy-627000.phy.3: phy poweron failed --> -110
[    4.676493] ufshcd-qcom 624000.ufshc: ufs_qcom_power_up_sequence:
phy power on failed, ret = -110
[    4.741859] ufshcd-qcom 624000.ufshc: Controller enable failed
[    4.741942] ufshcd-qcom 624000.ufshc: Host controller enable failed
[    4.746717] host_regs: 00000000: 0107001f 00000000 00010100 00000000
[    4.752822] host_regs: 00000010: 01000000 00010217 00000000 00000000
[    4.759424] host_regs: 00000020: 00000000 00000000 00000000 00000000
[    4.765751] host_regs: 00000030: 00000000 00000000 00000000 00000000
[    4.772090] host_regs: 00000040: 00000000 00000000 00000000 00000000
[    4.778438] host_regs: 00000050: 00000000 00000000 00000000 00000000
[    4.784758] host_regs: 00000060: 00000000 00000000 00000000 00000000
[    4.791096] host_regs: 00000070: 00000000 00000000 00000000 00000000
[    4.797434] host_regs: 00000080: 00000000 00000000 00000000 00000000
[    4.803789] host_regs: 00000090: 00000000 00000001 00000000 00000000
[    4.810109] ufshcd-qcom 624000.ufshc: No record of pa_err
[    4.816439] ufshcd-qcom 624000.ufshc: No record of dl_err
[    4.821732] ufshcd-qcom 624000.ufshc: No record of nl_err
[    4.827112] ufshcd-qcom 624000.ufshc: No record of tl_err
[    4.832497] ufshcd-qcom 624000.ufshc: No record of dme_err
[    4.837879] ufshcd-qcom 624000.ufshc: No record of auto_hibern8_err
[    4.843263] ufshcd-qcom 624000.ufshc: No record of fatal_err
[    4.849424] ufshcd-qcom 624000.ufshc: No record of link_startup_fail
[    4.855332] ufshcd-qcom 624000.ufshc: No record of resume_fail
[    4.861670] ufshcd-qcom 624000.ufshc: No record of suspend_fail
[    4.867351] ufshcd-qcom 624000.ufshc: No record of wlun resume_fail
[    4.873132] ufshcd-qcom 624000.ufshc: No record of wlun suspend_fail
[    4.879375] ufshcd-qcom 624000.ufshc: No record of dev_reset
[    4.885971] ufshcd-qcom 624000.ufshc: No record of host_reset
[    4.891617] ufshcd-qcom 624000.ufshc: No record of task_abort
[    4.897273] HCI Vendor Specific Registers 00000000: 000000c8
00000000 00000000 00000000
[    4.903001] HCI Vendor Specific Registers 00000010: 00000000
00000000 00000000 1c00052e
[    4.910870] HCI Vendor Specific Registers 00000020: 3f011300
20020000 00000000 00000000
[    4.918823] HCI Vendor Specific Registers 00000030: 00000000
00000000 00000000 00000000
[    4.926831] UFS_UFS_DBG_RD_REG_OCSC 00000000: 00000000 00000000
00000000 00000000
[    4.934769] UFS_UFS_DBG_RD_REG_OCSC 00000010: 00000000 00000000
00000000 00000000
[    4.942430] UFS_UFS_DBG_RD_REG_OCSC 00000020: 00000000 00000000
00000000 00000000
[    4.949876] UFS_UFS_DBG_RD_REG_OCSC 00000030: 00000000 00000000
00000000 00000000
[    4.957338] UFS_UFS_DBG_RD_REG_OCSC 00000040: 00000000 00000000
00000000 00000000
[    4.964800] UFS_UFS_DBG_RD_REG_OCSC 00000050: 00000000 00000000
00000000 00000000
[    4.972270] UFS_UFS_DBG_RD_REG_OCSC 00000060: 00000000 00000000
00000000 00000000
[    4.979733] UFS_UFS_DBG_RD_REG_OCSC 00000070: 00000000 00000000
00000000 00000000
[    4.987215] UFS_UFS_DBG_RD_REG_OCSC 00000080: 00000000 00000000
00000000 00000000
[    4.994675] UFS_UFS_DBG_RD_REG_OCSC 00000090: 00000000 00000000
00000000 00000000
[    5.002128] UFS_UFS_DBG_RD_REG_OCSC 000000a0: 00000000 00000000
00000000 00000000
[    5.009615] UFS_UFS_DBG_RD_EDTL_RAM 00000000: 00000000 a4491248
fcf4caf8 44ff663f
[    5.017059] UFS_UFS_DBG_RD_EDTL_RAM 00000010: 3495a3e2 7be93e99
2334e629 a9f5c77a
[    5.024530] UFS_UFS_DBG_RD_EDTL_RAM 00000020: e0edb246 e451c5b7
d020df23 c84d85e6
[    5.032019] UFS_UFS_DBG_RD_EDTL_RAM 00000030: 59e307b2 3685dda2
3d4484ee 33b4d9d9
[    5.039460] UFS_UFS_DBG_RD_EDTL_RAM 00000040: 4de322b3 5ba15f50
18e13d42 ca9f93e5
[    5.046936] UFS_UFS_DBG_RD_EDTL_RAM 00000050: 4ce04e39 954c996e
0645064b e235d257
[    5.054385] UFS_UFS_DBG_RD_EDTL_RAM 00000060: b92c1acb 281dc88f
56ff1877 3307091a
[    5.061851] UFS_UFS_DBG_RD_EDTL_RAM 00000070: fc19350a 222e4061
d2cc6217 1fa596f9
[    5.069381] UFS_UFS_DBG_RD_DESC_RAM 00000000: 00000fff 000245b9
40000fff 000245d7
[    5.076783] UFS_UFS_DBG_RD_DESC_RAM 00000010: ed10dc68 0036fe67
353c512f 0038a521
[    5.084250] UFS_UFS_DBG_RD_DESC_RAM 00000020: 8c4f244a 003677cc
c67731d1 00145113
[    5.091712] UFS_UFS_DBG_RD_DESC_RAM 00000030: fc33c5b6 00357243
fce1d206 002dc715
[    5.099178] UFS_UFS_DBG_RD_DESC_RAM 00000040: c54267f1 0039fc1e
e7e564f7 001d3070
[    5.106659] UFS_UFS_DBG_RD_DESC_RAM 00000050: a0c0bff6 002a0367
4a31b6ca 0021a267
[    5.114108] UFS_UFS_DBG_RD_DESC_RAM 00000060: 085b1f23 002c64ef
73830a12 0010ff39
[    5.121586] UFS_UFS_DBG_RD_DESC_RAM 00000070: f902904f 001b0514
714edb47 002ef768
[    5.129041] UFS_UFS_DBG_RD_DESC_RAM 00000080: 369035fc 0010e7fe
17d94504 003895c4
[    5.136508] UFS_UFS_DBG_RD_DESC_RAM 00000090: 26dd0675 001c14dc
7503fb3d 00040c95
[    5.143996] UFS_UFS_DBG_RD_DESC_RAM 000000a0: 945456e2 003932f0
bf4a51ed 002c0765
[    5.151444] UFS_UFS_DBG_RD_DESC_RAM 000000b0: c15810a5 001a4fc3
f9137305 0020c227
[    5.158902] UFS_UFS_DBG_RD_DESC_RAM 000000c0: 65b22d16 003b9a18
63d89770 000ab592
[    5.166365] UFS_UFS_DBG_RD_DESC_RAM 000000d0: d6257375 0016de4d
1e047776 000ec615
[    5.173849] UFS_UFS_DBG_RD_DESC_RAM 000000e0: 23184caa 001c5498
14cd841d 000a2d46
[    5.181299] UFS_UFS_DBG_RD_DESC_RAM 000000f0: 9a229d09 00041b11
d2249690 000e4e1b
[    5.188761] UFS_UFS_DBG_RD_DESC_RAM 00000100: 1a4f6c46 000202d1
07159e46 0011276c
[    5.196227] UFS_UFS_DBG_RD_DESC_RAM 00000110: be679f01 00042f38
1da6fd6c 000c3556
[    5.203694] UFS_UFS_DBG_RD_DESC_RAM 00000120: 1641cfe1 000996fd
7c902c15 0005bd54
[    5.211158] UFS_UFS_DBG_RD_DESC_RAM 00000130: 1ff37280 002c4c5d
3bb1d9f0 00286f65
[    5.218624] UFS_UFS_DBG_RD_DESC_RAM 00000140: 9bbc09e5 0028c6e7
5f5d9dc6 0035d8dd
[    5.226089] UFS_UFS_DBG_RD_DESC_RAM 00000150: 4a1d5167 00036152
da64f552 001ac503
[    5.233572] UFS_UFS_DBG_RD_DESC_RAM 00000160: 8d429104 003cdc65
cb6eb64b 0031356b
[    5.241021] UFS_UFS_DBG_RD_DESC_RAM 00000170: 4438c55a 003dc021
7859ed93 003748ff
[    5.248497] UFS_UFS_DBG_RD_DESC_RAM 00000180: 581e7129 00249e0f
1119282b 002eea5e
[    5.255973] UFS_UFS_DBG_RD_DESC_RAM 00000190: 36c4e1ff 003696c5
3d26c8d6 00341834
[    5.263423] UFS_UFS_DBG_RD_DESC_RAM 000001a0: 9569e755 0038c181
44a04716 00113eee
[    5.270880] UFS_UFS_DBG_RD_DESC_RAM 000001b0: 2b8126c4 00070e4e
3c00b95f 003efa6c
[    5.278349] UFS_UFS_DBG_RD_DESC_RAM 000001c0: fdac7bc9 002bbd97
0d1b10d7 00279d0e
[    5.285814] UFS_UFS_DBG_RD_DESC_RAM 000001d0: fd26970f 003ea7dd
7cfa0dd9 001abe65
[    5.293300] UFS_UFS_DBG_RD_DESC_RAM 000001e0: 462260e8 00088e88
6664d825 0025aedb
[    5.300740] UFS_UFS_DBG_RD_DESC_RAM 000001f0: e6e33f2d 0010a59d
646f03d7 00042b16
[    5.308241] UFS_UFS_DBG_RD_PRDT_RAM 00000000: b6500000 0000916c
c5801d67 000a3550
[    5.315674] UFS_UFS_DBG_RD_PRDT_RAM 00000010: 7437814c 0005a357
e44607eb 00093259
[    5.323140] UFS_UFS_DBG_RD_PRDT_RAM 00000020: 08ff015c 00082c54
09070e95 000c2704
[    5.330602] UFS_UFS_DBG_RD_PRDT_RAM 00000030: 3663d4c0 000c5d89
fb34130e 0009e7ee
[    5.338069] UFS_UFS_DBG_RD_PRDT_RAM 00000040: c6c207f0 0002a5d5
50e088ab 0004be17
[    5.345534] UFS_UFS_DBG_RD_PRDT_RAM 00000050: e0754a0b 000c5ceb
c99e1281 000549b2
[    5.353015] UFS_UFS_DBG_RD_PRDT_RAM 00000060: 3bcb7410 0004cd30
71149cd2 000fc80b
[    5.360465] UFS_UFS_DBG_RD_PRDT_RAM 00000070: 4012a0d8 000e04a1
6dc3ae4d 00080c54
[    5.367951] UFS_UFS_DBG_RD_PRDT_RAM 00000080: 00000040 00000004
e910c009 0001a567
[    5.375408] UFS_UFS_DBG_RD_PRDT_RAM 00000090: 0050cd49 0004eaa0
813bf322 000dd259
[    5.382856] UFS_UFS_DBG_RD_PRDT_RAM 000000a0: c920cae2 000a55a1
41816101 000f8065
[    5.390323] UFS_UFS_DBG_RD_PRDT_RAM 000000b0: e819a0b7 00050746
f1310132 000ada10
[    5.397787] UFS_UFS_DBG_RD_PRDT_RAM 000000c0: 2e4801ec 000a3517
f5544b9f 00008308
[    5.405253] UFS_UFS_DBG_RD_PRDT_RAM 000000d0: f345c26d 00041935
b001d7cf 0004a2ff
[    5.412737] UFS_UFS_DBG_RD_PRDT_RAM 000000e0: 48140248 0005010e
6039f044 0008131e
[    5.420185] UFS_UFS_DBG_RD_PRDT_RAM 000000f0: 0c418401 00000000
70518e69 00053a4c
[    5.427657] UFS_DBG_RD_REG_UAWM 00000000: 00000000 00000000 00000000 0001fec0
[    5.435117] UFS_DBG_RD_REG_UARM 00000000: 00000000 00000000 00000001 00000001
[    5.442255] UFS_DBG_RD_REG_TXUC 00000000: 00000000 00000000 00000000 00000000
[    5.449349] UFS_DBG_RD_REG_TXUC 00000010: 00000000 00000000 00000000 00000000
[    5.456467] UFS_DBG_RD_REG_TXUC 00000020: 00000000 00000000 00000000 00000000
[    5.463585] UFS_DBG_RD_REG_TXUC 00000030: 00000000 00000000 00000000 00000000
[    5.470719] UFS_DBG_RD_REG_TXUC 00000040: 00000000 00000000 00000000 00000000
[    5.477825] UFS_DBG_RD_REG_TXUC 00000050: 00000000 00000000 00000000 00000000
[    5.484963] UFS_DBG_RD_REG_TXUC 00000060: 00000000 00000000 00000000 00000000
[    5.492076] UFS_DBG_RD_REG_TXUC 00000070: 00000000 00000000 00000000 00000000
[    5.499189] UFS_DBG_RD_REG_TXUC 00000080: 00000000 00000000 00000000 00000000
[    5.506294] UFS_DBG_RD_REG_TXUC 00000090: 00000000 00000000 00000000 00000000
[    5.513413] UFS_DBG_RD_REG_TXUC 000000a0: 00000000 00000000 00000000 00000000
[    5.520532] UFS_DBG_RD_REG_TXUC 000000b0: 00000001 00000040 00000000 00000004
[    5.527665] UFS_DBG_RD_REG_RXUC 00000000: 00000000 00000000 00000000 00000004
[    5.534781] UFS_DBG_RD_REG_RXUC 00000010: 00000000 00000000 00000000 00000000
[    5.541883] UFS_DBG_RD_REG_RXUC 00000020: 00000000 00000000 00000000 00000000
[    5.549005] UFS_DBG_RD_REG_RXUC 00000030: 00000000 00000000 00000000 00000000
[    5.556121] UFS_DBG_RD_REG_RXUC 00000040: 00000000 00000000 00000000 00000000
[    5.563239] UFS_DBG_RD_REG_RXUC 00000050: 00000000 00000000 00000000 00000001
[    5.570357] UFS_DBG_RD_REG_RXUC 00000060: 00000040 00000000 00000004
[    5.577481] UFS_DBG_RD_REG_DFC 00000000: 00000000 00000000 00000000 00000000
[    5.583897] UFS_DBG_RD_REG_DFC 00000010: 00000000 00000000 00000000 00000000
[    5.590931] UFS_DBG_RD_REG_DFC 00000020: 00000000 00000000 00000000 00000000
[    5.597999] UFS_DBG_RD_REG_DFC 00000030: 00000000 00000000 00000000 00000000
[    5.604998] UFS_DBG_RD_REG_DFC 00000040: ffffffff 00000000 00000000
[    5.612039] UFS_DBG_RD_REG_TRLUT 00000000: 00000000 00000000
00000000 00000000
[    5.618013] UFS_DBG_RD_REG_TRLUT 00000010: 00000000 00000000
00000000 00000000
[    5.625318] UFS_DBG_RD_REG_TRLUT 00000020: 00000000 00000000
00000000 00000000
[    5.632510] UFS_DBG_RD_REG_TRLUT 00000030: 00000000 00000000
00000000 00000000
[    5.639715] UFS_DBG_RD_REG_TRLUT 00000040: 00000000 00000000
00000000 00000000
[    5.646918] UFS_DBG_RD_REG_TRLUT 00000050: 00000000 00000000
00000000 00000000
[    5.654126] UFS_DBG_RD_REG_TRLUT 00000060: 00000000 00000000
00000000 00000000
[    5.661349] UFS_DBG_RD_REG_TRLUT 00000070: 00000000 00000000
00000000 00000000
[    5.668536] UFS_DBG_RD_REG_TRLUT 00000080: 00000000 00000000
[    5.675741] UFS_DBG_RD_REG_TMRLUT 00000000: 00000000 00000000
00000000 00000000
[    5.681552] UFS_DBG_RD_REG_TMRLUT 00000010: 00000000 00000000
00000000 00000000
[    5.688585] UFS_DBG_RD_REG_TMRLUT 00000020: 00000000
[    5.695866] ufshcd-qcom 624000.ufshc: UFS Host state=0
[    5.701079] ufshcd-qcom 624000.ufshc: outstanding reqs=0x0 tasks=0x0
[    5.706047] ufshcd-qcom 624000.ufshc: saved_err=0x0, saved_uic_err=0x0
[    5.712550] ufshcd-qcom 624000.ufshc: Device power mode=0, UIC link state=0
[    5.718895] ufshcd-qcom 624000.ufshc: PM in progress=0, sys. suspended=0
[    5.725734] ufshcd-qcom 624000.ufshc: Auto BKOPS=0, Host self-block=0
[    5.732677] ufshcd-qcom 624000.ufshc: Clk gate=1
[    5.739003] ufshcd-qcom 624000.ufshc: last_hibern8_exit_tstamp at 0
us, hibern8_exit_cnt=0
[    5.743712] ufshcd-qcom 624000.ufshc: last intr at 0 us, last intr status=0x0
[    5.751790] ufshcd-qcom 624000.ufshc: error handling flags=0x0,
req. abort count=0
[    5.758985] ufshcd-qcom 624000.ufshc: hba->ufs_version=0x200, Host
capabilities=0x107001f, caps=0x12cf
[    5.766477] ufshcd-qcom 624000.ufshc: quirks=0x20, dev. quirks=0x0
[    5.775729] ufshcd-qcom 624000.ufshc: clk: core_clk, rate: 200000000
[    5.781911] ufshcd-qcom 624000.ufshc: clk: core_clk_unipro, rate: 150000000
[    5.788408] ufshcd-qcom 624000.ufshc: clk: core_clk_ice, rate: 300000000
[    5.799734] ufshcd-qcom 624000.ufshc: error -EIO: Initialization
failed with error -5
[    5.823482] ufshcd-qcom 624000.ufshc: error -EIO: ufshcd_pltfrm_init() failed
[    5.823655] ufshcd-qcom: probe of 624000.ufshc failed with error -5

-- 
With best wishes
Dmitry

