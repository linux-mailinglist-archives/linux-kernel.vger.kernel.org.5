Return-Path: <linux-kernel+bounces-12186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC99A81F10B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 18:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76324281ACF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 17:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972454653D;
	Wed, 27 Dec 2023 17:45:04 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C8746524;
	Wed, 27 Dec 2023 17:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6dbca8c6eeeso1109332a34.1;
        Wed, 27 Dec 2023 09:45:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703699102; x=1704303902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IijGyDJlNdIFWsVBwI/OZtAC73/0ucV8TiF4nNbafsQ=;
        b=N2FQakHUnSzgkmI4UylhwnWI0grw/x5uddZG+Ie9Md6qgAhabr5ytiboTFjafwGBEL
         hyXpw5PaSHBsjrCvJhXsoZhQaVmI1w8EWBtt/xQp3BjModg/fsERmNCzUxM9s9htlU5m
         xBKx8Io/ENa6ZYiLIXCb3zD4cUZE+UK8AnuU+m/B0S7FiIXEaRW/r+udt0okMUcRFXjy
         I8mBYUHEod/vtEi7pLXaQtMrE6UoWy0zY+VUAuVUilVBv7lpLjKZrKvT2ohtCBao4wFN
         pXj3eiCt/JOIfY7ZW+t2WHCg1l1GssZ6SGrYQjYCiAYHuXx5z+w+/YkXWC4dJ5RnuIrx
         ckjA==
X-Gm-Message-State: AOJu0YxkMDc5cavLkp9LuJ1LUyyAYqe0s0l7XWkMh0yxWKIqUdAEsoj/
	5ONY9Q9C1TJ2qVdqQw11OWGT2gPj8HdIiNHxI+c=
X-Google-Smtp-Source: AGHT+IHb5kyfPFFrbWmVJ2RKCSVFIpUezeFpLAGOrixJNax43QJUV3Usr6dq4uaUlo3cci21w+6ciLzJkHZTV9jT6mU=
X-Received: by 2002:a05:6820:358:b0:593:fbd5:10aa with SMTP id
 m24-20020a056820035800b00593fbd510aamr12501632ooe.1.1703699102027; Wed, 27
 Dec 2023 09:45:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20231227084252epcas2p3b063f7852f81f82cd0a31afd7f404db4@epcas2p3.samsung.com>
 <ZYvjiqX6EsL15moe@perf> <2023122701-mortify-deed-4e66@gregkh>
In-Reply-To: <2023122701-mortify-deed-4e66@gregkh>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 27 Dec 2023 18:44:51 +0100
Message-ID: <CAJZ5v0hGd0LzaBkiPYV3D7fnTm9aVOn6eT84q-_r1Rr-1Vupow@mail.gmail.com>
Subject: Re: [BUG] mutex deadlock of dpm_resume() in low memory situation
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Youngmin Nam <youngmin.nam@samsung.com>, rafael@kernel.org, len.brown@intel.com, 
	pavel@ucw.cz, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	d7271.choe@samsung.com, janghyuck.kim@samsung.com, hyesoo.yu@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 5:08=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Wed, Dec 27, 2023 at 05:42:50PM +0900, Youngmin Nam wrote:
> > Could you look into this issue ?
>
> Can you submit a patch that resolves the issue for you, as you have a
> way to actually test this out?  That would be the quickest way to get it
> resolved, and to help confirm that this is even an issue at all.

This is a real problem, unfortunately, and the fix would require some
infra changes AFAICS.

To address it, we would need a variant of async_schedule_node_domain()
that would bail out on low memory instead of attempting to run the
stuff synchronously which is harmful (not just for the deadlock
reason) in the suspend-resume paths.

I'll try to cut a test patch shortly.

