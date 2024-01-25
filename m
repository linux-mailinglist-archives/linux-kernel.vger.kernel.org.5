Return-Path: <linux-kernel+bounces-38526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4359783C10A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76A511C24137
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD49C2C696;
	Thu, 25 Jan 2024 11:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yupcpdxb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1802C68A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 11:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706182538; cv=none; b=RbYg9iVqrrURmBDsvs5uyIYaek/Cgy/pDVaEWz+UrUgIKvG7DSWOgu4VWBOQfYdz5f2wC7XXqFDOa82GVZqlueNbJG8YfavGOz7VGcL2xVMvHbgsW0oKo0akNpPtoltnsnM0snMXlxftkQ6mTSWl4w7DWeRnyZv8U2U5ED5Kw9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706182538; c=relaxed/simple;
	bh=QkSifBmhNnh9J/ox6L1kLoVfm7f2dkDpGrgfAkkmiqc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZaGs0Chz0GyrnZKEO9J+ukrrQk8c6SLnE3OIfTP+DcGieuWvVChZiSHUXM6XV4f/MpizFeVwTlxhD0R/ltN6r5xKm7O6nSE2ytDvSgMz6mQpidT3RITgkLBOLXPaqVtPG/zgbKpcvxeTlcJo2HqeJfGifi/ERGeWtiY/MYlZOYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yupcpdxb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706182535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ND0M38vqg/f3DX4i2e40ekWPh2ueLITyqRBQvx6nxv0=;
	b=YupcpdxbYUoxVsvZ7Y+UYCiAeelQyMHRjcD1Yj4xyZTrTikhqstNODWD/KaToHgvXUKoL4
	WYdwqSLMqt7hZ54rBxGcDXuVKvqNJDK1Sx+ul6yI4onJC0mTCxqBk5a52jj6ZJqsEfq3fN
	5pXZv6SFLLdpzUufXhF6pnSwq8Ru240=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-ECwceqxpMzi3xSahm9SBQw-1; Thu, 25 Jan 2024 06:35:33 -0500
X-MC-Unique: ECwceqxpMzi3xSahm9SBQw-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-5f6c12872fbso103077357b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 03:35:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706182531; x=1706787331;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ND0M38vqg/f3DX4i2e40ekWPh2ueLITyqRBQvx6nxv0=;
        b=c9NxuregroCR5ayVHkwKigg4ea6/0bXWw6MldrJCnpljf57tTPYaHvKQsVqCARpKRa
         l48/7nPNYoM0InCGiteLqOXCw9G/ScCi0RIn2URJMIQ6dXM8e/bcDaYyc5oQcxJBWQoJ
         8iSIpx1yqtiEYfo6IevC7YzfzO0rYS6xLqUpr0oHxTvP8poulj/Pbxc1fbGeiIina5an
         ViQIMCJLJrJhqkb6u64/xqCWpvjz8aH4Tp6SE9qX7opJffIcEYJbO7d0GteA+HRr/bL8
         GP9zFzdcyA+NudGvUtVYqFe7pXEHz16+yzljrTEOFtl/vcMQq++gT/Ybtieneoj2Z1Oc
         7ZVw==
X-Gm-Message-State: AOJu0YyKaS1xcGBYA0YRldNa2Q9W5Wcwl+KNmBI91aLEzc6HJqlkgE6W
	LpbBIYuE7JvAaSwmVMWQZV8fJ76QaVN519g1D0LfTeyovNUnDFroQV0ZS/hkKqrpT99zLwTarVr
	7uKlYNjvHaFLa/3DS+A0rFT0bM2oirakr4nTPeE5k2gHuV76/7IlSTjTbymPWdg==
X-Received: by 2002:a81:5702:0:b0:5ff:97d0:6535 with SMTP id l2-20020a815702000000b005ff97d06535mr552293ywb.83.1706182531059;
        Thu, 25 Jan 2024 03:35:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlpvmBp8xlQD5XCxbHNI/yAx/NEl7+aASAlI1TcIgGwaDJTRqIImA/z84168W/ZHhbcdOW+g==
X-Received: by 2002:a81:5702:0:b0:5ff:97d0:6535 with SMTP id l2-20020a815702000000b005ff97d06535mr552276ywb.83.1706182530618;
        Thu, 25 Jan 2024 03:35:30 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c6:4a05:9f01:cede:7b45:1f9d:67f])
        by smtp.gmail.com with ESMTPSA id bp31-20020a05620a459f00b007833c4dddfdsm4924094qkb.53.2024.01.25.03.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 03:35:30 -0800 (PST)
Date: Thu, 25 Jan 2024 11:35:26 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	Juri Lelli <juri.lelli@redhat.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Georges Da Costa <georges.da-costa@irit.fr>
Subject: [ANNOUNCE][CFP] Power Management and Scheduling in the Linux Kernel
 VI edition (OSPM-summit 2024)
Message-ID: <ZbJHfiWnujLz2Pfm@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Power Management and Scheduling in the Linux Kernel (OSPM-summit) VI
edition

May 30-31, 2024
Institut de Recherche en Informatique de Toulouse
Toulouse, France

---

:: FOCUS

OSPM is moving to France!

The VI edition of the Power Management and Scheduling in the Linux
Kernel (OSPM) summit aims at fostering discussions on power management
and (real-time) scheduling techniques. Summit will be held in Toulouse
(France) on May 30-31, 2024.

We welcome anybody interested in having discussions on the broad scope
of scheduler techniques for reducing energy consumption while meeting
performance and latency requirements, real-time systems, real-time and
non-real-time scheduling, tooling, debugging and tracing.

Feel free to take a look at what happened previous years:

 I   edition - https://lwn.net/Articles/721573/
 II  edition - https://lwn.net/Articles/754923/
 III edition - https://lwn.net/Articles/793281/
 IV  edition - https://lwn.net/Articles/820337/ (online)
 V   edition - https://lwn.net/Articles/934142/
               https://lwn.net/Articles/934459/
               https://lwn.net/Articles/935180/

:: FORMAT

The summit is organized to cover two days of discussions and talks.

The list of topics of interest includes (but it is not limited to):

 * Power management techniques
 * Scheduling techniques (real-time and non real-time)
 * Energy consumption and CPU capacity aware scheduling
 * Real-time virtualization
 * Mobile/Server power management real-world use cases (successes and
   failures)
 * Power management and scheduling tooling (configuration, integration,
   testing, etc.)
 * Tracing
 * Recap/lightning talks

Presentations (50 min) can cover recently developed technologies,
ongoing work and new ideas. Please understand that this workshop is not
intended for presenting sales and marketing pitches.

:: ATTENDING

Attending the OSPM-summit is free of charge, but registration to the
event is mandatory. The event can allow a maximum of 50 people (so, be
sure to register early!).

Registrations open on February 26th, 2024.
To register fill in the registration form available at
https://forms.gle/SooSmYMChBcn5rmM8

While it is not strictly required to submit a topic/presentation (see
below), registrations with a topic/presentation proposal will take
precedence.

:: SUBMIT A TOPIC/PRESENTATION

To submit a topic/presentation add its details to this list:
https://docs.google.com/spreadsheets/d/13lOYsbNWhQU7pNbyHI97fC7GT0Eu8aMbU9ATvPJfV0A/edit?usp=sharing

Or, if you prefer, simply reply (only to me, please :) to this email
specifying:

- name/surname
- affiliation
- short bio
- email address
- title
- abstract

Deadline for submitting topics/presentations is 19th of February 2024.
Notifications for accepted topics/presentations will be sent out 26th of
February 2024.

:: VENUE

The workshop will take place at IRIT [1], University of Toulouse [2],
France.

The workshop venue is accessible [3] from downtown, where you can find
most of the hotels/accommodations suggested below, by metro (line B) in
30 minutes [4]. You can reach IRIT by the metro B (approx one every 2
minutes in rush hours) or by bus (several lines, between 40 and 60
minutes depending on the line and the traffic). Several buses arrive at
the metro station of the university. A map of the city center with the
venue, transportation and food/drinks places is provided here [5].

It is recommended to pick a hotel close to a “Ligne B” subway station,
anywhere between “Jean-Jaures” and “Les Carmes”.

From the station, choose “Ramonville” direction and get off at the
station “Université Paul Sabatier” [6]. The station is right inside the
university. From there follow the map [7] to reach the IRIT building
entrance. 

Toulouse airport, “Aéroport Toulouse-Blagnac (TLS), Blagnac”, has a lot
of direct flights from European airports like Paris, Amsterdam, London,
Munich among others. There is a shuttle “La Navette” [8], every 20
minutes, bringing you to downtown in more or less 30 minutes depending
on the traffic. 

A list of hotels on the metro line B (direct to the workshop location):
http://www.hotel-oursblanc.com/
https://www.athome-ah.com/
https://www.discoverasr.com/fr/citadines/france/citadines-wilson-toulouse
https://www.pullman-toulouse-centre-ramblas.fr

[1] https://www.irit.fr/
[2] https://www.univ-tlse3.fr/
[3] https://maps.app.goo.gl/rdcrKx6x8ntm4uij6
[4] https://maps.app.goo.gl/Y8UPRvHmbrjCSnvu5
[5] https://www.toulouse-visit.com/interactive-map
[6] https://metro-toulouse.com/ligne-B-metro-toulouse.php
[7] https://goo.gl/maps/ojiAeQoL5Ewgb2gp7
[8] https://www.toulouse.aeroport.fr/en/transports/public-transport?tabs4633=tab_4631

:: ORGANIZERS

Juri Lelli (Red Hat)
Daniel Bristot de Oliveira (Red Hat)
Daniel Lezcano(Linaro)
Georges Da Costa (IRIT)
Tommaso Cucinotta (SSSA)
Lorenzo Pieralisi (Linaro)


