Return-Path: <linux-kernel+bounces-145630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 596088A58C5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0F87B24CD1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F128127E3A;
	Mon, 15 Apr 2024 17:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="envm3gPj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CCE82481;
	Mon, 15 Apr 2024 17:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200764; cv=none; b=UzlZbEd748zgbVB6BcdtSUSioioVM3eu7Z9FiLiWk7gvcFdA+zUcNlAOSoa3XqMeDrSCeCkS69R0kEK8tSwbL2imV7B6idMo7xjIcUO6ME2AqPVguFRFfAgmi2SOM9f88rKy0ZpQXbUkyV2cf9E0ZotgpiReBbkdamJLZ+oWuGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200764; c=relaxed/simple;
	bh=4a9TlTGikPdPtvIswhMDPVXsOAtTJIQPwslpOZDf9fY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WjX8LsYuPZ0KyCXAF4nlQgVgIWsnsisRY1Yv057p5j42ZuM7imrm8UcoMwU4xW8TAl96kMTLsHdtRZgsWzDof48+NfH49L6/kpCbD9263CyO7LIA7kDL8Ld1pjI5TLOQbsr9CvGyDvbg4RdjLvfQBSpvR2NuQ0xVzuQBVlBL23U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=envm3gPj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB0AEC2BD11;
	Mon, 15 Apr 2024 17:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713200763;
	bh=4a9TlTGikPdPtvIswhMDPVXsOAtTJIQPwslpOZDf9fY=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=envm3gPjZkPR25rFILSSoDGtvq58d0n5TS2Ogmxra3RmmqJOLqTClzNaQo60Rcy/8
	 axCfm2/V7ALzK2j+/+nve1rMfBSKxfrc/66w1h9SakHpGtRH39qBxvnQIWELc/JNt1
	 70y5d3MUtd06wenDYBRLLmN9O8hgIPdUs+/sO+G2y5beX4FDbqCiauXeAdrQXsfWnB
	 PckYPDZC66KLbwdVo1CdwHkuaE+chrIGFCZZCCb53eAm56qC0RIamfBj/CR5RSCwYK
	 oRbMjLRnnDWF2GpgqY32AMqlw6eI3R983vlkCtFSx5kVqwvNCfGp/PfehO9ZBJzbmk
	 asMALYe/CuGnA==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-518c9ff3e29so1860444e87.0;
        Mon, 15 Apr 2024 10:06:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVxg/QDIDT+2uFnvQSb2pIZUnrfgF3JX4CUPStTW+RnUMx6reBpkC5C/2rV0f6gLXzUzIo/7PDwKLyYQf9e0m9nNDRlnVHd+mKXS2I4MrFZeZxwP/Zc5EjyzDn25A7QbqxED3QJdoxF99ELngt/1h5HsfJMfmDRJdoB69Fz39rHlkCq4jnAqW5v+dUd1QmtesEA6QMXYvocKooomLhcDj39lUuH3ylPoEQkSn82SF35NmtxbKoAF2AdoFUlnzgV98cyP+HFNwMT
X-Gm-Message-State: AOJu0YwK1k2oZMcCOfAtzlgBTO/t+HBEL8eHKauKZEOF7ZhQK7lNyrOE
	lUMQLbwORDPorWOCdZejufmc4oJQ+VtlCjZaqoGXgRBuFANLmgu8Ve/c/xRNgeYqJPF1Jc6NYJe
	fITp+oJfp+ZjYmMQot63cGLzq1g==
X-Google-Smtp-Source: AGHT+IGj52gH0/Dg5INd/xZRyWwlGDPcfmpSpbX0KU82iJTE7+TtYLQcTn0dGxCxYIzg49fhJoCRFzAjpf+6SCkqXUk=
X-Received: by 2002:a2e:b0ef:0:b0:2da:320a:68d9 with SMTP id
 h15-20020a2eb0ef000000b002da320a68d9mr3627965ljl.13.1713200741392; Mon, 15
 Apr 2024 10:05:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412222857.3873079-1-robh@kernel.org> <Zh0vXinxy7woerJQ@hu-bjorande-lv.qualcomm.com>
 <CAA8EJpqL2T4bJZqtZ9KF=V2NLnFxUjouA6_Hu_H07DofifZaoQ@mail.gmail.com>
In-Reply-To: <CAA8EJpqL2T4bJZqtZ9KF=V2NLnFxUjouA6_Hu_H07DofifZaoQ@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 15 Apr 2024 12:05:26 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+q3OLEMT=d8=d9o1D9deKGQ5TAtZg_bgptDPQ1cWcctw@mail.gmail.com>
Message-ID: <CAL_Jsq+q3OLEMT=d8=d9o1D9deKGQ5TAtZg_bgptDPQ1cWcctw@mail.gmail.com>
Subject: Re: [PATCH] arm/arm64: dts: Drop "arm,armv8-pmuv3" compatible usage
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <quic_bjorande@quicinc.com>, soc@kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Dinh Nguyen <dinguyen@kernel.org>, 
	Tsahee Zidenberg <tsahee@annapurnalabs.com>, Antoine Tenart <atenart@kernel.org>, 
	Khuong Dinh <khuong@os.amperecomputing.com>, Liviu Dudau <liviu.dudau@arm.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	Robert Richter <rric@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, "Paul J. Murphy" <paul.j.murphy@intel.com>, 
	Daniele Alessandrelli <daniele.alessandrelli@intel.com>, Andrew Lunn <andrew@lunn.ch>, 
	Gregory Clement <gregory.clement@bootlin.com>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	=?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
	Heiko Stuebner <heiko@sntech.de>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	Jisheng Zhang <jszhang@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, linux-fsd@tesla.com, 
	Michal Simek <michal.simek@amd.com>, devicetree@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-realtek-soc@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 11:52=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Mon, 15 Apr 2024 at 16:46, Bjorn Andersson <quic_bjorande@quicinc.com>=
 wrote:
> >
> > On Fri, Apr 12, 2024 at 05:28:51PM -0500, Rob Herring wrote:
> > [..]
> > >  arch/arm64/boot/dts/qcom/qcm2290.dtsi                | 2 +-
> > >  arch/arm64/boot/dts/qcom/qdu1000.dtsi                | 2 +-
> > >  arch/arm64/boot/dts/qcom/sdm630.dtsi                 | 2 +-
> > >  arch/arm64/boot/dts/qcom/sdx75.dtsi                  | 2 +-
> >
> > Acked-by: Bjorn Andersson <andersson@kernel.org>
>
> Note, we'd need to override PMU compatibles in sdm636.dtsi and
> sdm660.dtsi. Ideally it should come as the same patch.

Uh, that's an A for reuse, but an F for readability... It's sdm632 as
well. Will drop sdm630.

Rob

