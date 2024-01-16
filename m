Return-Path: <linux-kernel+bounces-28347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2B582FD1F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B221B22EA7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BCB23779;
	Tue, 16 Jan 2024 22:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="GNcNqQGI"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF61200C1
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 22:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705443912; cv=none; b=Wm4Koxopx4+RxsXWUHZZ6xCfPcRZJtgwovBFfAbFT4hHME4OvuRVZR3rXuHi2EGDJZW5JkM5I/g+kpyxhqyt4TP+tKdLL0MtgBXXofGYV8HHGlldeqSqIiFa++xIlaZzNa3QOLrf089mVyzbcSmBERcbvL5D1Ly8JOz752N05yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705443912; c=relaxed/simple;
	bh=iJ39MH4mqeyNt9Nv3baKzqxKkS+WUtb/vJwlljcnfSY=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=bjZv54vWp7XUfPqiLTWT60sUz+RNhhCQGcUoMZMzewa1JgeXHCsBMcG8At7oGeKGUPVINC8D1a6aTM+TnIxRbHpazErhpiYE9kfzO0urCloa7tJ88AUEJQU1QDOm3tDMVoCCOQ4Xr3FEzVyBJQoZcFVGs3lkqiAPMH1MsXUNCs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=GNcNqQGI; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50e79299da9so2030609e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 14:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1705443908; x=1706048708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nv0E2bFJC3bwFCY7TgFvWMFZeHrdBHqDiGwtffKOX+s=;
        b=GNcNqQGIyJ2j7ULNXl8Ld8x+umUNp9eDtDOZ65BvoCOrZfiLgtycKCrkuyRLPUSFfc
         HMckU8xaStYYv/C2n+kpQSU7+El6EzlKmXDDlDbqGCSsxPUJgzsDg7z9CwHa7AFuGXzO
         EnE7rS2x2cWth7nQrLE4Dp94tPUfkr/SLViws+aZ75s5lEuKIhYW0irKdEaUi6Ijo6xG
         veElBOQPMH1KDCaR7uB+vOEZDctlQ2WFqxGw2+49ThhV6uXV4Hg3NWMo7SoFeYE2NJ4V
         Yd2sCKA7xaJRz+lV5rP7Nd8G27lGUr2SWKEcvCqgta9YbDhIQGYWRlKYqTkZuHS9oJRs
         2GcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705443908; x=1706048708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nv0E2bFJC3bwFCY7TgFvWMFZeHrdBHqDiGwtffKOX+s=;
        b=rx8NTJ7r9+FL5RelBC2MpEp69BAoIP0VmvVgd6I3s4ynBXNwmNQu5LKaz0Uh8u68RH
         9xw1d3dcdHr7fpcoAl8DTbMHT1MZkEHMT1qmadccHeVp0L2cRD7wnXB5mOfpEBdBmjy7
         9+yb7AjPY/ifavZaNI+LMvCjHDgYqA0ZAIM2sP45Jhw8xEFXVZH8LjcvSum9QSViUxFc
         rzaPKpbmCM3dDydlIzIPDXxZaNd34vZLd0Yl9SWVYkwnGz1G+RAqp2vKF9vxfqRNdFiz
         QoyUXOKSj1mIdCqhF4OBx+uqXaTUhiYGypKGvxUSXNJdgVa19dZeJ5SM1NS1WtwVwZzZ
         UtdQ==
X-Gm-Message-State: AOJu0Yzu2tcbzVBGExrWLRHJQm42Hf3+9DKE2O/m2NkOm2D6GsI31Gd7
	Y0RDLRA6gXV1JtMHm44QcjDNHKcWiXJHClI46e4A2qIfVQDlcQ==
X-Google-Smtp-Source: AGHT+IHPxnArc1i1NEtO+g7RKhOk+DOBD0hl7PQzbEjRxh5BnDk5Ic97VuxcaFO1JrX6VJqebbfiMiPHOjvd42/cTx8=
X-Received: by 2002:a2e:2f06:0:b0:2cc:f5b9:bbf7 with SMTP id
 v6-20020a2e2f06000000b002ccf5b9bbf7mr7638928ljv.3.1705443908133; Tue, 16 Jan
 2024 14:25:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116193542.711482-1-tmenninger@purestorage.com> <04d22048-737a-4281-a43f-b125ebe0c896@lunn.ch>
In-Reply-To: <04d22048-737a-4281-a43f-b125ebe0c896@lunn.ch>
From: Tim Menninger <tmenninger@purestorage.com>
Date: Tue, 16 Jan 2024 14:24:55 -0800
Message-ID: <CAO-L_44YVi0HDk4gC9QijMZrYNGoKtfH7qsXOwtDwM4VrFRDHw@mail.gmail.com>
Subject: Re: [PATCH] net: dsa: mv88e6xxx: Make *_c45 callbacks agree with
 phy_*_c45 callbacks
To: Andrew Lunn <andrew@lunn.ch>
Cc: f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 11:59=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote=
:
>
> On Tue, Jan 16, 2024 at 07:35:42PM +0000, Tim Menninger wrote:
> > Set the read_c45 callback in the mii_bus struct in mv88e6xxx only if th=
ere
> > is a non-NULL phy_read_c45 callback on the chip mv88e6xxx_ops. Similarl=
y
> > for write_c45 and phy_write_c45.
> >
> > In commit 743a19e38d02 ("net: dsa: mv88e6xxx: Separate C22 and C45 tran=
sactions")
> > the MDIO bus driver split its API to separate C22 and C45 transfers.
> >
> > In commit 1a136ca2e089 ("net: mdio: scan bus based on bus capabilities =
for C22 and C45")
> > we do a C45 mdio bus scan based on existence of the read_c45 callback
> > rather than checking MDIO bus capabilities then in
> > commit da099a7fb13d ("net: phy: Remove probe_capabilities") we remove t=
he
> > probe_capabilities from the mii_bus struct.
> >
> > The combination of the above results in a scenario (e.g. mv88e6185)
> > where we take a non-NULL read_c45 callback on the mii_bus struct to mea=
n
> > we can perform a C45 read and proceed with a C45 MDIO bus scan. The sca=
n
> > encounters a NULL phy_read_c45 callback in the mv88e6xxx_ops which impl=
ies
> > we can NOT perform a C45 read and fails with EOPNOTSUPP. The read_c45
> > callback should be NULL if phy_read_c45 is NULL, and similarly for
> > write_c45 and phy_write_c45.
>
> Hi Tim
>
> What does phylib do with the return of -EOPNOTSUPP? I've not tested
> it, but i would expect it just keeps going with the scan? It treats it
> as if there is no device there? And since it never accesses the
> hardware, this should be fast?
>
> Or is my assumption wrong? Do you see the EPOPNOTSUPP getting reported
> back to user space, and the probe failing?
>
>      Andrew
>

Hi Andrew,

It bubbles up as EIO (the translation happens in get_phy_c45_ids when
get_phy_c45_devs_in_pkg fails) and ultimately causes the probe to fail.

The EIO causes the scan to stop and fail immediately - the way I read
mdiobus_scan_bus_c45, only ENODEV is permissible.

From logs:
$ dmesg | grep mv88e6
[   12.951149] mv88e6085 ixgbe-mdio-0000:05:00.0:00: switch 0x1a70
detected: Marvell 88E6185, revision 2
[   13.272812] mv88e6085 ixgbe-mdio-0000:05:00.0:00: Cannot register
MDIO bus (-5)
[   13.401140] mv88e6085: probe of ixgbe-mdio-0000:05:00.0:00 failed
with error -5
[   13.413105] mv88e6085 ixgbe-mdio-0000:05:00.1:00: switch 0x1a70
detected: Marvell 88E6185, revision 2
[   13.730227] mv88e6085 ixgbe-mdio-0000:05:00.1:00: Cannot register
MDIO bus (-5)
[   13.858336] mv88e6085: probe of ixgbe-mdio-0000:05:00.1:00 failed
with error -5

Tim

