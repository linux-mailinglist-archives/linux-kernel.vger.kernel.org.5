Return-Path: <linux-kernel+bounces-55755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 231F284C142
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 01:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C348828269E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 00:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEFC9454;
	Wed,  7 Feb 2024 00:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qd5DrmMH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653958BF0
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 00:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707264608; cv=none; b=tSY3I0vgvk0/E33+gRnYVB8ggjQyrqWs/F1qsN+p6r5G54EHtavpsnMDsGVak9VVUzjcziZEfooO6pCu+glCZ7WE1K4ZepEsKBDBY4oRUMUGBUuIbFr4IfcWYUGtbhezb8y2IS/UCIvmhJaXCaB7T6NWjFMr7eDI8gL8zPFb0gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707264608; c=relaxed/simple;
	bh=Cdcap5uMXxvB1kBQ9xVZaxBupdA8BdwIYAkLrQteCBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZK/FFgoWXzAvMvhex5wXUybp2V3q0iE5s9axUdyi265IPmQh7a1nxgX/Ae0zvoghz7NSgdeJtrX8f3Ggr1oh4K+RB0IaVrYOwTW9GzhghSYUsoJa667SkhKH0/bTSiSrK8A4rU9Av4t8mr/rvKiPsXB89P2jXd4xpxNwRTzSp0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qd5DrmMH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707264605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8PeIaiF8S8G4r3R+HzDgZLObyMgMOMMGNfccF3lVkkc=;
	b=Qd5DrmMHSdfsH5buqcXwAg0yItjSDP43rxorIYoGGepxc5A+D4ZfeUDEotGay/czZRSX0p
	ryuhozYfIo2xDzylru1GgeV4xoAwJxMMobxdW0lw1+CnNmoNqm8SBIDNwyXaMC8WDIh9VA
	5GbQJad03SKRrs8f41bwrZSvoeh30oU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-XX7g7iENPw2VSJ1V--bzQw-1; Tue, 06 Feb 2024 19:10:02 -0500
X-MC-Unique: XX7g7iENPw2VSJ1V--bzQw-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6800a9505ddso992196d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 16:10:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707264601; x=1707869401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8PeIaiF8S8G4r3R+HzDgZLObyMgMOMMGNfccF3lVkkc=;
        b=qxHqIXR+SvdcUsthn0znfLwVLfVZkPmh9g3ExbNq50tTNiFQMB1rSzUNWaTJUCBiiS
         28A5GWVGwrZS1wtcwG6eG1HCDpYRrDo910qeibgCWgb9eXrG4oDxF9T3XjVMCRYA0s3A
         CFaNXH3GQu5CDrVBf1vvhzgmqM+JT9dbhzVsRRJ4YaUn+uf8jrjzdKWMTtRJNoReRH/p
         9bKu9/csACbYDbf1OrCPcC9S+6HUVi6F6XjImpRO67n6gC1E1eZGYiXOtjddPbr6V+Sz
         xUfMGrnsODdkfK147Mu9Bpmk3xCkVH6mzfUdDDR9JALcPeFRWFFirSy/QzNzbmBZKjL2
         WbkQ==
X-Gm-Message-State: AOJu0YwbJfWFwNMD0zJiI/KzCEoUC9WECMCKB4QaCMK8l2fwiogJ7Wfg
	IWW2pwVx4HVlc/xnSYjNxp3At7+9SRHGiJnA1COzRNXPqnDG+scj9X1HKwn4nvw92yGetFT918A
	arkj9D4F1AjQE15KdPoPXZ9l96nNiYDO7DKtYk4bS7juOgZbCscLPnmIASlZ1SQ==
X-Received: by 2002:a05:6214:410e:b0:68c:49a1:5c95 with SMTP id kc14-20020a056214410e00b0068c49a15c95mr4407509qvb.55.1707264601667;
        Tue, 06 Feb 2024 16:10:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdJS1fYNbxcKarJ0njOQ0m9/eqTJtiD59/XUfeqwKtwbIQlfAhxokwVel6zXVbgv04fzCArA==
X-Received: by 2002:a05:6214:410e:b0:68c:49a1:5c95 with SMTP id kc14-20020a056214410e00b0068c49a15c95mr4407481qvb.55.1707264601395;
        Tue, 06 Feb 2024 16:10:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWvxIl6coLO1rbDQJ8RjF1D3gsUxXQJ9LrU9v6Bw0nQ4l0uUwnWpqCL/cwxq6ZJnGUyz5k1WcPlepJBLGpQ03D78Ghv/YzIBaWLaVQrW8zLkWPQhKFmVgMABZHxrfnf5sLsjbUpaJBQRgOC2RJIa90ukRmb2i5NKbAn5TTVjGlfA1SW5EMBwMvIYVy4BBS6ZV/CwO6/WnCU22wLEqeFUtsyRn1jaljfOsHmMADayBTiXUGm00RADK0B8WbRkpZ9Z4XLn/huGKJFmXhc8ooETwnsk8G5VIoiQi1kv1QTlkBgdPxKVSDpcCp1DObertMWC+7LGHgSIW7eNxfMyqG+7wk5L6SNkZ4cCY5e5QP8ImGMA85XfCkRTgS7xNOw4JxwDU07BTthNpnCrplEFCktBQVgMRQI9vhiMO5f7hwbICZqQPoO6to6WKuPP0dIvG5ax9I=
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id xq2-20020a05620a5ca200b00783534c512bsm21043qkn.32.2024.02.06.16.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 16:10:01 -0800 (PST)
Date: Tue, 6 Feb 2024 18:09:58 -0600
From: Andrew Halaney <ahalaney@redhat.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: neil.armstrong@linaro.org, 
	Krishna Kurapati <quic_kriskura@quicinc.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, quic_ppratap@quicinc.com, 
	quic_jackp@quicinc.com
Subject: Re: Re: [PATCH 3/3] arm64: dts: qcom: sa8540-ride: Enable first port
 of tertiary usb controller
Message-ID: <6q2ocvrujbli42rjddflyol74xianr7j47jwcgdnnmwjanv25d@uw2da7zulqqd>
References: <20240206114745.1388491-1-quic_kriskura@quicinc.com>
 <20240206114745.1388491-4-quic_kriskura@quicinc.com>
 <23824242-1b37-4544-ae9a-0a5a0582580e@linaro.org>
 <CAA8EJpqbXvKMQktGsxMFJnR+fXoOz8hFmm+E3ROPTjjiD0QLvg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpqbXvKMQktGsxMFJnR+fXoOz8hFmm+E3ROPTjjiD0QLvg@mail.gmail.com>

On Tue, Feb 06, 2024 at 03:30:32PM +0200, Dmitry Baryshkov wrote:
> On Tue, 6 Feb 2024 at 15:28, <neil.armstrong@linaro.org> wrote:
> >
> > On 06/02/2024 12:47, Krishna Kurapati wrote:
> > > From: Andrew Halaney <ahalaney@redhat.com>
> > >
> > > There is now support for the multiport USB controller this uses so
> > > enable it.
> > >
> > > The board only has a single port hooked up (despite it being wired up to
> > > the multiport IP on the SoC). There's also a USB 2.0 mux hooked up,
> > > which by default on boot is selected to mux properly. Grab the gpio
> > > controlling that and ensure it stays in the right position so USB 2.0
> > > continues to be routed from the external port to the SoC.
> 
> What is connected to the other port of the MUX?

/me blows off the dust on the schematic

It's a 1:2 mux, and one option is the out the board, the other
is a test point I believe if I'm reading things right, although its not
labeled so I'm not sure anyone would actually find it on the board.

> 
> > >
> > > Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> > > Co-developed-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> > > Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> > > ---
> > >   arch/arm64/boot/dts/qcom/sa8540p-ride.dts | 21 +++++++++++++++++++++
> > >   1 file changed, 21 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> > > index b04f72ec097c..eed1ddc29bc1 100644
> > > --- a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> > > +++ b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> > > @@ -503,6 +503,18 @@ &usb_2_qmpphy0 {
> > >       status = "okay";
> > >   };
> > >
> > > +&usb_2 {
> > > +     pinctrl-0 = <&usb2_en>;
> > > +     pinctrl-names = "default";
> > > +
> > > +     status = "okay";
> > > +};
> > > +
> > > +&usb_2_dwc3 {
> > > +     phy-names = "usb2-port0", "usb3-port0";
> > > +     phys = <&usb_2_hsphy0>, <&usb_2_qmpphy0>;
> > > +};
> > > +
> > >   &xo_board_clk {
> > >       clock-frequency = <38400000>;
> > >   };
> > > @@ -655,4 +667,13 @@ wake-pins {
> > >                       bias-pull-up;
> > >               };
> > >       };
> > > +
> > > +     usb2_en: usb2-en-state {
> > > +             /* TS3USB221A USB2.0 mux select */
> > > +             pins = "gpio24";
> > > +             function = "gpio";
> > > +             drive-strength = <2>;
> > > +             bias-disable;
> > > +             output-low;
> > > +     };
> > >   };
> >
> > Isn't gpio-hog the preferred way to describe that ?
> 
> That depends. As this pinctrl describes board configuration, I'd agree
> with Neil.

I unfortunately don't have the experience with gpio-hog to weigh in
here, but wouldn't be opposed to Krishna switching it if that's what's
recommended for this type of thing.

> 
> 
> -- 
> With best wishes
> Dmitry
> 


