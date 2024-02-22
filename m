Return-Path: <linux-kernel+bounces-76266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C69085F4EC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4283E28976F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0869938FB2;
	Thu, 22 Feb 2024 09:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s0qw/iTE"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC5C381A0
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708595179; cv=none; b=hRMwn7CxSY7pU8mrpVK9TXsAu4f1wluM5t2DWJ/CAKVSw3gRJDANkaF8oN3bDEfh8/MGP4FDSXwspWw2Rlgmo9dM19a93MmFJJ+ho40y+4yZdKDa1PT+2e6UQRdro55eexP0wXc3ZxTtGc8wAw7AEh46ulAHGCXqT9Mu1oDOHZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708595179; c=relaxed/simple;
	bh=OXpl8KtnkdumkkL/oL3Rll5PWQ3rF0whL8FYYh60i3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fu9X+BgSziCIS2IjDB1YgSNFuW1pDV+JW/JI5k8ABz++U6mkM7wIqP5QBU+6Kp01auB68jb/6cEyNhooYSOFW0KVIsN/4VsVfkKrQLYh9Wc5Fb/TGXT8IUdBCsRBrAw58Qx1v2t/d2ho9NIq5HWyYXYth+zKiANKNZNhreykBZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s0qw/iTE; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5650c27e352so7559a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 01:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708595176; x=1709199976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CO9OLuYsn9M5g/f+gNkO5HVcagw8JPRKpX2lST/Z1zc=;
        b=s0qw/iTEvikM/obz5ZM4wbhfhISNkQrUa7hFn1rkYXEX6NvzKwW4mW0NOkfSii1ngM
         3h/2izEzsqN/lNjRF4KHGhIjUPfk/sDhDsiqp8BT6M1xii85NrdM3BmkHgQD0qldxeni
         VdrbZl/X5zeE8BwKgPQt47NC56WUBKWkbbNlOcpONVsa2OAH+KH27TIH/0Ju0fEuZASO
         8OSLNlhrqmDLLblu3TezLmiL0C/QOCCyQzPQscnwusvE6X2fKuPi68+u8bih4kIOSGcW
         JA6/PaZTSk+SgUOU9vdkKZbXP/0m7CfVYwkwiuTrrgQ9pBHKdzgx+zT5Yx+axzx7txUf
         jLFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708595176; x=1709199976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CO9OLuYsn9M5g/f+gNkO5HVcagw8JPRKpX2lST/Z1zc=;
        b=cTkbqXMjU9h4390e62wwtC4x+wCSlvTvSXeFenOWXQjzcz9Cx/bbTyeubNbGMvY8UQ
         Vf15Si11eigJ7wSRH6rIio19wcRsDWu2WQ4/HFfT2eg35K8WZB/Pv+Wg1cXWdNHRkIqY
         ZetfVW5o+1k56kPE+4fVjgeRNP93rBEYCcFQordqeBZSAeCb1abf9jF/6anGK07mMdR3
         VIpR/CN9kRaVQWx59W5L4p9h92f5p1wRnDepTNt6GOslzuH1sRKRyh/m2R2oBbxkVoW/
         HLV5xh0r9v8KpC6Jm/yHILD5iTliCepr8KP0AMUt2uXmL/Ol0EcaHplaL0uR/CHIQnnR
         +YgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNz2RmXPNOt9/xFeFPv7O8rHUSZnwT76rl5g3yoePeYgGVG8sGHQk6O5Qx6BuzMLDmw0zteR8MJ/hPBMiwVdDf8H2sB9/iQjFfg8Tq
X-Gm-Message-State: AOJu0YzvAgvA2e22bTiiYYSQCGzi1hdHHCZsghlUu3eV7rSytW5qrPfm
	qINrPo7TDfAoblnWuaQ+pBRIV7GsqwYAlWNsNftI13wjqAVy9VkvtqLsQxgDcKt6nrwW12F72or
	iPpD5xphgegUmfBs1Pku6Yk5C7hPA/OwHD2Bs
X-Google-Smtp-Source: AGHT+IHM+zVGs1vfCf6mEt0YThwspRts0ylLL/r+issShzGze5aBxEviehGvjwwmjLZ77XUgJQ4G1x6+ofxUaAbkDfU=
X-Received: by 2002:a50:9f04:0:b0:562:9d2:8857 with SMTP id
 b4-20020a509f04000000b0056209d28857mr385846edf.6.1708595175380; Thu, 22 Feb
 2024 01:46:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219061008.1761102-1-pumahsu@google.com> <20240219061008.1761102-3-pumahsu@google.com>
 <0b4464eb-631e-4c9f-a7c8-3451be15d8b4@kernel.org> <CAGCq0LYFMrFmxeKZE9g-O61+N03rJoGL0XvXJVya0Yx-ZasvBA@mail.gmail.com>
 <bea850fe-19e8-492e-b885-6d01b389c32c@kernel.org>
In-Reply-To: <bea850fe-19e8-492e-b885-6d01b389c32c@kernel.org>
From: Puma Hsu <pumahsu@google.com>
Date: Thu, 22 Feb 2024 17:45:37 +0800
Message-ID: <CAGCq0La_XHJw4cscahiDWM-n03dWf8SUQ2Zw0YZgHyXwKcURyQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] usb: xhci: Add support for Google XHCI controller
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: mathias.nyman@intel.com, gregkh@linuxfoundation.org, 
	Thinh.Nguyen@synopsys.com, badhri@google.com, royluo@google.com, 
	howardyen@google.com, albertccwang@google.com, raychi@google.com, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 5:53=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 21/02/2024 10:31, Puma Hsu wrote:
> > On Mon, Feb 19, 2024 at 8:22=E2=80=AFPM Krzysztof Kozlowski <krzk@kerne=
l.org> wrote:
> >>
> >> On 19/02/2024 07:10, Puma Hsu wrote:
> >>> In our SoC platform, we support allocating dedicated memory spaces
> >>> other than system memory for XHCI, which also requires IOMMU mapping.
> >>> The rest of driver probing and executing will use the generic
> >>> xhci-plat driver.
> >>>
> >>> We support USB dual roles and switch roles by generic dwc3 driver,
> >>> the dwc3 driver always probes xhci-plat driver now, so we introduce
> >>> a device tree property to probe a XHCI glue driver.
> >>>
> >>> Sample:
> >>>   xhci_dma: xhci_dma@99C0000 {
> >>>     compatible =3D "shared-dma-pool";
> >>>     reg =3D <0x00000000 0x99C0000 0x00000000 0x40000>;
> >>>     no-map;
> >>>   };
> >>>
> >>>   dwc3: dwc3@c400000 {
> >>>     compatible =3D "snps,dwc3";
> >>>     reg =3D <0 0x0c400000  0 0x10000>;
> >>>     xhci-glue =3D "xhci-hcd-goog";
> >>
> >> NAK, that's not DWC3 hardware in such case.
> >
> > By introducing this property, users can specify the name of their
> > dedicated driver in the device tree. The generic dwc3 driver will
>
> DT is not a place for driver stuff.
>
>
> > read this property to initiate the probing of the dedicated driver.
>
> I know, but it is not a reason to add stuff to DT.
>
> > The motivation behind this is that we have dedicated things
> > (described in commit message) to do for the XHCI driver in our
> > device. BTW, I put this property here because currently there is
> > no xhci node, xhci related properties are put under dwc3 node.
>
> Sorry, you miss the point. Either you have pure DWC3 hardware or not.
> You claim now you do not have pure hardware, which is reasonable,
> because it is always customized per-vendor. In such case you cannot
> claim this is a pure DWC3. You must provide bindings for your hardware.
>
> Now, if you claim you have a pure DWC3 hardware without need for any
> vendor customizations, then entire patchset is fake try to upstream your
> Android vendor stuff. We talked about such stuff many times on mailing
> list, so for obvious reasons I won't repeat it. Trying to push vendor
> hooks and vendor quirks is one of the most common mistakes, so several
> talks already say: don't do this.
>
> > It will be appreciated if there are alternative or more appropriate
> > approaches, we welcome discussion to explore the best possible
> > solution. Thanks.
>
> And what's wrong with all previous feedbacks for similar
> Google/Samsung/Artpec/Tensor vendor hacks? Once or twice per year some
> folks around Google or Samsung try to push such, they all receive the
> same feedback and they disappear, so I have to repeat the same feedback
> to the next person... Please go through previous patches from
> @samsung.com for various subsystems.
>
> Documentation/devicetree/bindings/submitting-patches.rst
> Documentation/devicetree/bindings/writing-bindings.rst
> +other people or my talks on Devicetree
>
> Summarizing: Devicetree is for hardware, not for your driver
> hooks/quirks/needs. Describe properly and fully the hardware, not your
> driver.

Thank you Krzysztof for the explanation. I will study and explore
the possibility of integrating the stuff we want into the generic driver.

>
> Best regards,
> Krzysztof
>

