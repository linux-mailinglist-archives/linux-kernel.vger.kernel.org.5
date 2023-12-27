Return-Path: <linux-kernel+bounces-12252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F55881F1FA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 21:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFBF31C2265D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 20:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4108547F7B;
	Wed, 27 Dec 2023 20:50:15 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF4D47F69;
	Wed, 27 Dec 2023 20:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3bb7e50679bso336145b6e.0;
        Wed, 27 Dec 2023 12:50:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703710212; x=1704315012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rUvcnoDQa7BmxbZaffxRN9h8EUNEzN5n5IycYr5Fua4=;
        b=m2ug5lXE4WaGtRbqlv1NP6sXUxQosOfGBBLGVf+3Nc/OM+dW8RJpi7aKlmZ0LqZrwn
         VWuYLOV6oAElz3DI4ENdT494KrXZ2lorroFQMPBktQ/r/uQRJ0QRy9Zp6Ka+XAFeU50o
         c3UJzXEbWk4vAMraJYP1odYrHylTpZGepzls89iaYaAXXfYdKBpnMqX2PW6LA5w18OjU
         WXVao4bk8REf6x/vTJ1xnSdepdnfIHaLNnaCDG5coFRL1NHINeq/Z0+p2SWzn8dwh1Kq
         IYhUdm5TpUgf6+dIlk5uc3XQRnvmpwZ1x56mzD0/CUBzD9yllwwOgVHPOTGCGQtY8ylp
         zogQ==
X-Gm-Message-State: AOJu0YyiX7p2j/SR0QUZwWZUU04GNN879Di1pHhDGYZSGkyA/lxMUayf
	CuwM9H/m9D2Pls4jaVR89dXRbln1ZOzJ2UV63mo=
X-Google-Smtp-Source: AGHT+IE5f1EYLVkNXbT9YLi/wb/oWEyUAssobeSCyrneCWtfm2xdqV1g1iL8b7hY0qZYbrt8ZEHkQi4KCeuqxWnNbMQ=
X-Received: by 2002:a05:6808:2029:b0:3bb:6d31:602a with SMTP id
 q41-20020a056808202900b003bb6d31602amr18957335oiw.1.1703710212559; Wed, 27
 Dec 2023 12:50:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20231227084252epcas2p3b063f7852f81f82cd0a31afd7f404db4@epcas2p3.samsung.com>
 <2023122701-mortify-deed-4e66@gregkh> <5754861.DvuYhMxLoT@kreacher> <5755916.DvuYhMxLoT@kreacher>
In-Reply-To: <5755916.DvuYhMxLoT@kreacher>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 27 Dec 2023 21:50:01 +0100
Message-ID: <CAJZ5v0jupWr_89mttKMg-KGa6_dpu62JiUkUaueMfHVgeUXYWg@mail.gmail.com>
Subject: Re: [BUG] mutex deadlock of dpm_resume() in low memory situation
To: Greg KH <gregkh@linuxfoundation.org>, Youngmin Nam <youngmin.nam@samsung.com>
Cc: len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, d7271.choe@samsung.com, 
	janghyuck.kim@samsung.com, hyesoo.yu@samsung.com, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 7:58=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.ne=
t> wrote:
>
> On Wednesday, December 27, 2023 7:39:20 PM CET Rafael J. Wysocki wrote:
> > On Wednesday, December 27, 2023 5:08:40 PM CET Greg KH wrote:
> > > On Wed, Dec 27, 2023 at 05:42:50PM +0900, Youngmin Nam wrote:
> > > > Could you look into this issue ?
> > >
> > > Can you submit a patch that resolves the issue for you, as you have a
> > > way to actually test this out?  That would be the quickest way to get=
 it
> > > resolved, and to help confirm that this is even an issue at all.
> >
> > Something like the appended patch should be sufficient to address this =
AFAICS.
> >
> > I haven't tested it yet (will do so shortly), so all of the usual discl=
aimers
> > apply.
> >
> > I think that it can be split into 2 patches, but for easier testing her=
e
> > it goes in one piece.
>
> Well, please scratch this, it will not handle "async" devices properly.

This

https://lore.kernel.org/linux-pm/6019796.lOV4Wx5bFT@kreacher/

should address the issue properly (it has been lightly tested).

Please give it a go and let me know if it works for you (on top of 6.7-rc7)=
.

