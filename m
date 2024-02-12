Return-Path: <linux-kernel+bounces-61688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3E5851560
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C6761F26448
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C6847A40;
	Mon, 12 Feb 2024 13:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nGoFUZMZ"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342B245BE8
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707744433; cv=none; b=E0fSgCQIqd2TDhi/1EonwB08XJmzr/tkVyhy7HBfiUn5UMC9EKvZ5BNIheuVnGqs/Xo5sR2w7ZqAswpJBfj9buskJ7dBCYROfHnNMjKY8yDvwE6QC5xHMGYa1i3fe6k6246r7tvBuEafqsRSvwdrE0BjtBsS/i6gq6rVTZezCn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707744433; c=relaxed/simple;
	bh=UgJE8QN26wTVcYTwslTRxKcPKfKIluHtkCRbsH9i8HU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ICwOzGhzF6v9wsgSCSqRU3vsZX2b/1b1MxWAqooR8e0eorsN4d5Vl/eA53EFiaSuWyG6C0+97m4g1ejHQtlutNPyl8hehIr56dfrQgXlmia88oe13TK0MwN62if7Bsbeu2LTc3Foy88y+J2D2rK67JFPy/yLqZ8/hv1DI84vs4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nGoFUZMZ; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc745927098so2616568276.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 05:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707744430; x=1708349230; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=voyZqJo/cIne41l5d+IDZJTmO0BrPsamqEotiqg3SZ4=;
        b=nGoFUZMZjXBY1U0CR9u5EV/I7+w50xRnP2TGdlY8u+rN+EW1dn41R6dVDZwwKFFe2w
         bcrSTwDuMhhOZm6MqEf6Pn4Ze+iggGnGTlBW7eJTK/U7XegVi9xt5/H/EgdzAYEeBKv5
         2TUNrf+CJoAnfNLZbE0x1hKE5DYF4W95sbJwBeCezzKcAAbMx03mt6d7YpTnhp6o2QOT
         B+eO6uqvL2imvfm5mOZ27Jwr6b4bBsfl6Opl2RPEcsq7VzQoLo8WtKek/EOXZsxPOkVH
         zUdfguGe088cj2rYTpEmvb/ON1NqMoPNXSMyjZoVYLRv9vMnFEztQlcm8aZ5Ou/AcTlB
         XKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707744430; x=1708349230;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=voyZqJo/cIne41l5d+IDZJTmO0BrPsamqEotiqg3SZ4=;
        b=dIGf+YBXKOlamslNi643O0GZPDcxHekg901BIlxa7rAzr25DBMnVI7Um1aOODFjPcV
         /wKq9+4LyMRlEOJrgOyhiWiiZ6Lt2ph3H70k3D56oZvBKewZNlPsqpqN7oguLcLGebet
         yVdUEuMSaKDWRsZhD+wtiVU+MfVmZ4pfVMav1IkJxol3Uo2zLpq4egFCit25OEJFuclQ
         Cm4GbFesQzPb9WoWNe2Ca0zepmL9HuHjUvlUf0YxXYZHXmYCcxXVVYGkmdPimPr3WVVT
         YrZmlX7I2v8I1sBCyFLwOnyZt0/Gxd0QhhT6MdOY5DEQdY294Cl3PrYlYvOlCtoXhUEG
         2fIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRKINwHjWyuEmBk0NDSZKCVDorMoVX0IjhMTAXOS5QmXT5MW+MhHH1DKRLt/f3toKzZ1dYfzmN8PX8BFeJqP82xdPK7f5fBprwukUF
X-Gm-Message-State: AOJu0YxxmLE4ydpzcY9xP0YmQ9eiIgfioU8W4JC2hG89GMbUUVhOVqwx
	NWwpjg54Rqzge5+PJS7DPsamvqyxOYuBkK1wwI3NmsQR6Ny9AieEqDJwrunNV0YMY5be3QWg9h2
	O+TP7+Voq1/tw9XJxAy1Tx89hrASrWBBdwZjCwQ==
X-Google-Smtp-Source: AGHT+IH2FeH9b90zOdUSsLyLSaIqH2hxHl8fPGS0QQV4ey1Z5w/YkWI71/Atkzgl/Hq1bPQgBvQtf2TUNVTPAW1kDUc=
X-Received: by 2002:a05:6902:2604:b0:dc7:4fbd:2b55 with SMTP id
 dw4-20020a056902260400b00dc74fbd2b55mr6374378ybb.45.1707744430126; Mon, 12
 Feb 2024 05:27:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207-enable_pcie-v1-1-b684afa6371c@quicinc.com>
 <CAA8EJpqjm_2aE+7BtMkFUdet11q7v_jyHbUEpiDHSBSnzhndYA@mail.gmail.com>
 <dec2976e-6e1e-6121-e175-210377ff6925@quicinc.com> <CAA8EJprsm5Tw=vFpmfEKL8fxS-S+aW+YR0byfyL=v78k75TGEw@mail.gmail.com>
 <3ad77846-b4a8-80ee-e9e1-d5cbf4add6d8@quicinc.com> <CAA8EJprRF0tVFZK9c=MT8bSRcBdRvcugBaeEzpX5-wfRyNgc3Q@mail.gmail.com>
 <c8be2bbf-a51c-a38f-6e6f-a88801f953d5@quicinc.com> <20240209075716.GA12035@thinkpad>
 <CAA8EJppfzc_dM9c9mHPVWheVxi-1gJxCmaWPvreELijEQDDSyA@mail.gmail.com> <20240212131551.GA74465@thinkpad>
In-Reply-To: <20240212131551.GA74465@thinkpad>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 12 Feb 2024 15:26:59 +0200
Message-ID: <CAA8EJpo2bbWokvRs0=RhTYKYyAEd-axyQnFZxzLkqFQ-NyPEzQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: qcs6490-rb3gen2: Add PCIe nodes
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com, 
	quic_ramkri@quicinc.com, quic_nitegupt@quicinc.com, quic_skananth@quicinc.com, 
	quic_parass@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Feb 2024 at 15:16, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Fri, Feb 09, 2024 at 12:56:18PM +0200, Dmitry Baryshkov wrote:
> > On Fri, 9 Feb 2024 at 09:57, Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > >
> > > On Fri, Feb 09, 2024 at 12:58:15PM +0530, Krishna Chaitanya Chundru wrote:
> > > >
> > > >
> > > > On 2/8/2024 8:49 PM, Dmitry Baryshkov wrote:
> > > > > On Thu, 8 Feb 2024 at 16:58, Krishna Chaitanya Chundru
> > > > > <quic_krichai@quicinc.com> wrote:
> > > > > > On 2/8/2024 12:21 PM, Dmitry Baryshkov wrote:
> > > > > > > On Thu, 8 Feb 2024 at 08:14, Krishna Chaitanya Chundru
> > > > > > > <quic_krichai@quicinc.com> wrote:
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > On 2/7/2024 5:17 PM, Dmitry Baryshkov wrote:
> > > > > > > > > On Wed, 7 Feb 2024 at 12:42, Krishna chaitanya chundru
> > > > > > > > > <quic_krichai@quicinc.com> wrote:
> > > > > > > > > >
> > > > > > > > > > Enable PCIe1 controller and its corresponding PHY nodes on
> > > > > > > > > > qcs6490-rb3g2 platform.
> > > > > > > > > >
> > > > > > > > > > PCIe switch is connected to PCIe1, PCIe switch has multiple endpoints
> > > > > > > > > > connected. For each endpoint a unique BDF will be assigned and should
> > > > > > > > > > assign unique smmu id. So for each BDF add smmu id.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > > > > > > > > > ---
> > > > > > > > > >     arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 42 ++++++++++++++++++++++++++++
> > > > > > > > > >     1 file changed, 42 insertions(+)
> > > > > > > > > >
> > > > > > > > > > diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > > > > > > > > > index 8bb7d13d85f6..0082a3399453 100644
> > > > > > > > > > --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > > > > > > > > > +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > > > > > > > > > @@ -413,6 +413,32 @@ vreg_bob_3p296: bob {
> > > > > > > > > >            };
> > > > > > > > > >     };
> > > > > > > > > >
> > > > > > > > > > +&pcie1 {
> > > > > > > > > > +       perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
> > > > > > > > > > +
> > > > > > > > > > +       pinctrl-0 = <&pcie1_reset_n>, <&pcie1_wake_n>;
> > > > > > > > > > +       pinctrl-names = "default";
> > > > > > > > > > +
> > > > > > > > > > +       iommu-map = <0x0 &apps_smmu 0x1c80 0x1>,
> > > > > > > > > > +                   <0x100 &apps_smmu 0x1c81 0x1>,
> > > > > > > > > > +                   <0x208 &apps_smmu 0x1c84 0x1>,
> > > > > > > > > > +                   <0x210 &apps_smmu 0x1c85 0x1>,
> > > > > > > > > > +                   <0x218 &apps_smmu 0x1c86 0x1>,
> > > > > > > > > > +                   <0x300 &apps_smmu 0x1c87 0x1>,
> > > > > > > > > > +                   <0x400 &apps_smmu 0x1c88 0x1>,
> > > > > > > > > > +                   <0x500 &apps_smmu 0x1c89 0x1>,
> > > > > > > > > > +                   <0x501 &apps_smmu 0x1c90 0x1>;
> > > > > > > > >
> > > > > > > > > Is the iommu-map really board specific?
> > > > > > > > >
> > > > > > > > The iommu-map for PCIe varies if PCIe switch is connected.
> > > > > > > > For this platform a PCIe switch is connected and for that reason
> > > > > > > > we need to define additional smmu ID's for each BDF.
> > > > > > > >
> > > > > > > > For that reason we defined here as these ID's are applicable only
> > > > > > > > for this board.
> > > > > > >
> > > > > > > So, these IDs are the same for all boards, just being unused on
> > > > > > > devices which have no bridges / switches connected to this PCIe host.
> > > > > > > If this is correct, please move them to sc7280.dtsi.
> > > > > > >
> > > > > > Yes ID's will be same for all boards. we can move them sc7280.dtsi
> > > > > > but the BDF to smmu mapping will be specific to this board only.
> > > > > > if there is some other PCIe switch with different configuration is
> > > > > > connected to different board of same variant in future again these
> > > > > > mapping needs to updated.
> > > > >
> > > > > Could you possibly clarify this? Are they assigned one at a time
> > > > > manually? Or is it somehow handled by the board's TZ code, which
> > > > > assigns them sequentially to the known endpoints? And is it done via
> > > > > probing the link or via some static configuration?
> > > >
> > > > There is no assignment of SID's in TZ for PCIe.
> > > > PCIe controller has BDF to SID mapping table which we need to
> > > > program with the iommu map table.
> > > >
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/dwc/pcie-qcom.c?h=v6.8-rc3#n997
> > > >
> > > > Based upon switch the BDF to SID table will change for example I had two
> > > > switches with one switch has 2 PCIe ports and other has 3 ports one
> > > > embedded port which supports multiple functions.
> > > >
> > > > For the first switch the BDF's are
> > > >       - 0x000(root complex),
> > > >       - 0x100(USP),
> > > >       - 0x208(DSP 0),
> > > >       - 0x210(DSP 1),
> > > >       - 0x300(endpoint connected to DSP 0),
> > > >       - 0x400( endpoint connected to DSP 1).
> > > >
> > > > For 2nd switch the BDF's are
> > > >       - 0x000(root complex),
> > > >       - 0x100(USP),
> > > >       - 0x208(embeeded DSP 0),
> > > >       - 0x210(DSP 1),
> > > >       - 0x218 (DSP 2),
> > > >       - 0x300(embedded endpoint function 0),
> > > >       - 0x301 (embedded endpoint function 1)
> > > >       - 0x400( endpoint connected to DSP 1)
> > > >       - 0x500(endpoint connected to DSP2).
> > > >
> > > > For these two switches we need different BDF to SID table so for that
> > > > reason we are keeping iommu map here as this is specific to this board.
> > > >
> > >
> > > I don't understand why the SID table has to change between PCIe devices. The SID
> > > mapping should be part of the SoC dtsi, where a single SID would be defined for
> > > the devices under a bus. And all the devices under the bus have to use the same
> > > SID.
> >
> > This sounds like a sane default, indeed. Nevertheless, I see a point
> > in having per-device-SID assignment. This increases isolation and can
> > potentially prevent security issues. However in such case SID
> > assignment should be handled in some automagic way. In other words,
> > there must be no need to duplicate the topology of the PCIe bus in the
> > iommu-maps property.
> >
>
> Yes, address space isolation is the primary motive behind this patch. But as
> you said, we should not do it by hardcoding the SIDs in the board DTS. It won't
> scale and is not a proper solution.
>
> Instead, the issue should be addressed in the IOMMU layer by working with the
> IOMMU folks.
>
> It should be noted that we _cannot_ use any arbitrary SID for PCIe bus. HYP/TZ
> will fault the transactions coming with different SIDs than the ones assigned
> to them. So we still need to pass that info from DT to IOMMU layer.

Yes, passing a range or a masked value sounds logical. Passing 1:1
mapping for a dynamic bus doesn't.


-- 
With best wishes
Dmitry

