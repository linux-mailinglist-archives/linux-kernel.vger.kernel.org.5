Return-Path: <linux-kernel+bounces-49688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB2C846E25
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C2CE1C257A2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B8F13BEBC;
	Fri,  2 Feb 2024 10:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="cF9R312n"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBF313BE8F
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 10:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706870595; cv=none; b=jC/l5VDrTIcVWScaXSIJa5FH9T1GYwZMCm76zeGRk5NcCGa4h495xIu+PZ0bMmBqFYlyurQ1LNSmu7LBWVrxeiqkyckBUD0tn/D+PT42Tg3DEWO4oQUKMbizvmtURoRHMQkMIRcapWjUxUyLKGctf+CI3jiVFA34gbhGvIWUMPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706870595; c=relaxed/simple;
	bh=n/TBT6eeeVIdmYf9KcgVa0+DUc21Gug7LVdv0WrTFr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MmCCaWJ4WpRPuihU8AZqhJXv7qP/gceBuHruUL8XGvnkJHcD4PFOrPmYx/LuIPKBb8pFSa6yXNSrTwpwTxmSAx3LYI29xKoqy/bS+8WNCd4liFGWg9kZMFdSN8AZ3aUEyS6i6zuLwSvdEPN6K32BamHHweoSpc+0/u0LNGzK7VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=cF9R312n; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5d8df2edd29so1535792a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 02:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1706870592; x=1707475392; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=awBS6iTmTY/pPBdOIloYqmySk/iEEgDule0WFnqfXEo=;
        b=cF9R312nMkbSdJwsenGn9iW4KO0Abj70zi0vtG5I1l3d16I0WklBG+1gtLNRJJ1Fnx
         WkhCw7Ylkkxx+8bhEqGeFTo3LNfwOcTn+wq/1XXsW44gyne6vPn/IsUPFAI32IIP1jeY
         z6BpeDLiw/aBLx0bYVK0odonXG5cD3OMFdA71AwWnioOCAcEwKLlQMGo97tNarFbYvnl
         cNJc3pqLBu5K9S3KmH6CujXS1dOrtsyNq96dG/MUUkdU7eRvs9JhKHGq+WTq36uUG/7r
         pd6qIoTltdmPWdYRHQEsZvzIYx6j96DkxV0la1KhjFLs84R+pt84npxvCw7B15ZplTCn
         2rlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706870592; x=1707475392;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=awBS6iTmTY/pPBdOIloYqmySk/iEEgDule0WFnqfXEo=;
        b=gEK5hnmSLrQuw/gCKAt1XKRLTbbY2L71GAR9xi8Jm2I12fQC74WFr+DpNWqVPvnykC
         8nVaX1o0tboL4nBIDpWCOpdBvkdp6zhlvu5pb1BzvyRU+2DZtZ37jgutzcYwqoqyxDLG
         Q3ofjGtWbK7lpG1nlVa5EbFkL5omnugWnwyZUdmL3IAWepNNxmTLe7axdZhDmP1Bmnbh
         Feun4AurnRMNTp9WpCnNnPoVW3ZNz2D4R1OMGfsWTlettTiB3hEjBq6FA0FZXYZO4Epl
         p6AwvWA1qRfoqlS+ZzIm+85RzOAfSHDU1fHk1vFwBH8qfOhrqhf98Ge6sea7mu3ZcFBo
         BERg==
X-Gm-Message-State: AOJu0YziizVkRTtkYESgwqjso5h20/KiZiWsLqhEXW0Ybubpsfk8N8qT
	jJqskOhL6IpfARgjzLAtFKUkxNhankCSMLB62bxf9Xafy7eWNywGlL4q4pjT4EUxBxkCsQSD0xn
	zmTd8pME39B7GRHhYxUwccUnUOVR2ZsrTXz7i/Q==
X-Google-Smtp-Source: AGHT+IGuiheUv23/PDxBQSBrhF8MxuJjiXvLTEQiL5VtSmukfKdGGWgNGBz5VJI7SY4IaW6Yp26vgwj+2R69veWTwrc=
X-Received: by 2002:a05:6a21:195:b0:19e:3161:2c97 with SMTP id
 le21-20020a056a21019500b0019e31612c97mr5830984pzb.10.1706870592435; Fri, 02
 Feb 2024 02:43:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130115651.457800-1-naresh.solanki@9elements.com>
 <1c855a34-8a0d-491e-bfd2-24635b41c86f@linaro.org> <20240131163516.000043df@Huawei.com>
 <20240131-stylized-defile-d8fe346ab197@spud>
In-Reply-To: <20240131-stylized-defile-d8fe346ab197@spud>
From: Naresh Solanki <naresh.solanki@9elements.com>
Date: Fri, 2 Feb 2024 16:13:02 +0530
Message-ID: <CABqG17iNxfKFNqydkgo6gL8ZmaZ_bqm=pG8kNEhzx_h2eaGuhQ@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: iio: afe: voltage-divider: Add io-channel-cells
To: Conor Dooley <conor@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Peter Rosin <peda@axentia.se>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	mazziesaccount@gmail.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000005725be061063c7db"

--0000000000005725be061063c7db
Content-Type: text/plain; charset="UTF-8"

Hi,


On Wed, 31 Jan 2024 at 22:24, Conor Dooley <conor@kernel.org> wrote:
>
> On Wed, Jan 31, 2024 at 04:35:16PM +0000, Jonathan Cameron wrote:
> > On Wed, 31 Jan 2024 09:29:59 +0100
> > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> >
> > > On 30/01/2024 12:56, Naresh Solanki wrote:
> > > > voltage-divider is always an iio consumer at the same time it is
> > > > optionally an iio provider.
> > > > Hence add #io-channel-cells
> > > > Also update example.
> > > >
> > >
> > > Fix
> > > wrapping
> > > and
> > > proper
> > > sentences. Each sentence finishes with full stop.
Sure
> > >
> > > ...
> > > >    output-ohms:
> > > >      description:
> > > >        Resistance Rout over which the output voltage is measured. See full-ohms.
> > > > @@ -75,12 +82,17 @@ examples:
> > > >              spi-max-frequency = <1000000>;
> > > >          };
> > > >      };
> > > > -    sysv {
> > > > +    p12v_vd: sysv {
> > >
> > > No, drop label.
Sure
> > >
> > > >          compatible = "voltage-divider";
> > > >          io-channels = <&maxadc 1>;
> > > > +        #io-channel-cells = <1>;
> > > >
> > > >          /* Scale the system voltage by 22/222 to fit the ADC range. */
> > > >          output-ohms = <22>;
> > > >          full-ohms = <222>; /* 200 + 22 */
> > > >      };
> > > > +    iio-hwmon {
> > > > +        compatible = "iio-hwmon";
> > > > +        io-channels = <&p12v_vd 0>;
> > >
> > > The same question as for v2. Drop unrelated example.
Sure
> >
> > Conor requested an example of the device acting as a consumer and a provider.
> > Might have meant in the patch description?
> >
> > Conor?
>
> I wanted it in the property description to help with understanding when
> to use it. I don't think the extra example nodes actually help you
> understand what it is doing, only how to write one yourself once you
> know you need it.
I'm not sure if I get it right but what I understood is that a
voltage-divider can
also be a provider to other devices & hence the property.
Also do you want me to put a complete example of it in description ?

Regards,
Naresh
>
> Thanks,
> Conor.

--0000000000005725be061063c7db
Content-Type: text/plain; charset="US-ASCII"; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
Content-ID: <18d695f183061a8e03b2>
X-Attachment-Id: 18d695f183061a8e03b2

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0NCg0KaUhVRUFCWUlBQjBXSVFSaDI0NkVHcS84
UkxoRGpPMTR0REdIb0lKaTBnVUNaYnA3VVFBS0NSQjR0REdIb0lKaQ0KMHFVS0FQMFd3NDh5OFZw
bDBBSzBvanEwR1RGeitwbnIrdldGZXRLNlY4ZmJTeVEwWXdFQWcrc2IwZTVFWHR0eA0KWWM1d3FV
Nk9HK2FsaSt6MkNOQy9PcDRrZEF5UE1BRT0NCj1pM2JYDQotLS0tLUVORCBQR1AgU0lHTkFUVVJF
LS0tLS0NCg==
--0000000000005725be061063c7db--

