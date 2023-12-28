Return-Path: <linux-kernel+bounces-12828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3198481FA97
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 20:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDF851F2223E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 19:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6550B101E8;
	Thu, 28 Dec 2023 19:13:18 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925D9101C1;
	Thu, 28 Dec 2023 19:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-593f182f263so1327692eaf.0;
        Thu, 28 Dec 2023 11:13:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703790795; x=1704395595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M0OKN9HKwBCVGBwl7+BR58ZezIupQSEZhUTpvcAXEIc=;
        b=miUOEzgsbYxLpsZEoJ3zdjCeKV1qdEMn+SVYXlvwvtwscs63Ql2JpeX7fqLjUXj1ql
         JTkKXMinRyKsi+PBpno09m/dJFBWKT1G4Ti/Bce/1kUF/TVXIpuGht+OrpcFZZ23bhsq
         1RzJA3roHsfO9xboT7cJrhnwZiYy9pxJLQdyCb1fDe0ZrAjg+OfYwjySTIAtFfFmJMno
         K3b0ajD+6I552h/O23/H//RhCkRyRnEJphqOn3aLi247QxEANpwkdQuh5cXF8+RttkeU
         Gc3izvAaVtva+SnB8TZJAuBvQjT6GONP0Ltc4a0xGRmKG0832Aq7tTEyIcAlWUTG2WJX
         35TQ==
X-Gm-Message-State: AOJu0YwexXoKmFtedP9C5j/4krwguNXFAwdBy4ia0CUZSRPX68j5ufjm
	05RiAVJ0X6F0MgPMbabHykVcmgPtAgjzjaFU3FIp2lkf
X-Google-Smtp-Source: AGHT+IHNVleauOP87gCEE931G0e8QpUkJGdtV9h5iHXztG7FwEnzgVVRmZFKGsjidN7ECBFe0Kb2s/meciXM2WR+E1w=
X-Received: by 2002:a4a:c719:0:b0:594:c433:66e6 with SMTP id
 n25-20020a4ac719000000b00594c43366e6mr6467169ooq.0.1703790795635; Thu, 28 Dec
 2023 11:13:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231227104532.2671761-1-daniel.lezcano@linaro.org>
In-Reply-To: <20231227104532.2671761-1-daniel.lezcano@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 28 Dec 2023 20:13:05 +0100
Message-ID: <CAJZ5v0goxF4sbipnLJCGkzBzKQgrYXyWSPtCbLjLqZ61AHo08Q@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] thermal/debugfs: Add thermal cooling device
 debugfs information
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@rjwysocki.net, lukasz.luba@arm.com, rui.zhang@intel.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 11:46=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The thermal framework does not have any debug information except a
> sysfs stat which is a bit controversial. This one allocates big chunks
> of memory for every cooling devices with a high number of states and
> could represent on some systems in production several megabytes of
> memory for just a portion of it. As the sysfs is limited to a page
> size, the output is not exploitable with large data array and gets
> truncated.
>
> The patch provides the same information than sysfs except the
> transitions are dynamically allocated, thus they won't show more
> events than the ones which actually occurred. There is no longer a
> size limitation and it opens the field for more debugging information
> where the debugfs is designed for, not sysfs.
>
> The thermal debugfs directory structure tries to stay consistent with
> the sysfs one but in a very simplified way:
>
> thermal/
>  -- cooling_devices
>     |-- 0
>     |   |-- clear
>     |   |-- time_in_state_ms
>     |   |-- total_trans
>     |   `-- trans_table
>     |-- 1
>     |   |-- clear
>     |   |-- time_in_state_ms
>     |   |-- total_trans
>     |   `-- trans_table
>     |-- 2
>     |   |-- clear
>     |   |-- time_in_state_ms
>     |   |-- total_trans
>     |   `-- trans_table
>     |-- 3
>     |   |-- clear
>     |   |-- time_in_state_ms
>     |   |-- total_trans
>     |   `-- trans_table
>     `-- 4
>         |-- clear
>         |-- time_in_state_ms
>         |-- total_trans
>         `-- trans_table
>
> The content of the files in the cooling devices directory is the same
> as the sysfs one except for the trans_table which has the following
> format:
>
> Transition      Hits
> 1->0            246
> 0->1            246
> 2->1            632
> 1->2            632
> 3->2            98
> 2->3            98
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
> Changelog:
>   - v5
>     - Removed a spurious change in thermal_helper.c, missed to remove it =
in v4 (Rafael)

This one LGTM now.

I've only spotted a few very minor things that can be fixed up while
applying the patch.

>   - v4
>     - Fixed kerneldoc description ordering (Rafael)
>     - Fixed comment (Rafael)
>     - Renamed s/cdev_value/cdev_record/ (Rafael)
>     - Used union instead of a common 'value' field in cdev_record (Rafael=
)
>     - Renamed s/cdev/cdev_dbg/ for clarity (Rafael)
>     - Renamed s/dfs/thermal_dbg/ for clarity (Rafael)
>     - Renamed s/list/lists/ in the place where there are array of lists (=
Rafael)
>     - Inverted initialization logic when allocating a cdev_record (Rafael=
)
>     - Moved now =3D ktime_get() closer to the place where it is used (Raf=
ael)
>     - Moved two lines down to a condition (Rafael)
>     - Removed strange and unexpected addition of function (Rafael)
>   - v3
>     - Fixed kerneldoc description (kbuild)
>     - Made some functions static
>   - v2
>     - Added parameter names to fix kbuild report
>     - Renamed 'reset' to 'clear' to avoid confusion (Rafael)
>     - Fixed several typos and rephrased some sentences (Rafael)
>     - Renamed structure field name s/list/node/ (Rafael)
>     - Documented structures and exported functions (Rafael)
>     - s/trans_list/transitions/ (Rafael)
>     - s/duration_list/durations/ (Rafael)
>     - Folded 'alloc' and 'insert' into a single function (Rafael)
>     - s/list/lists/ as it is an array of lists (Rafael)
>     - s/pos/entry/ (Rafael)
>     - Introduced a locking in the 'clear' callback function (Rafael)
>     - s/to/new_state/ and s/from/old_state/ (Rafael)
>     - Added some comments in thermal_debug_cdev_transition() (Rafael)
>     - Explained why char[11] (Rafael)
>     - s/Hits/Occurrences/ (Rafael)
>     - s/Time/Residency/ (Rafael)
>     - Constified structure pointer passed to thermal_debug_cdev_transitio=
n()
>     - s/thermal_debug_cdev_transition()/thermal_debug_cdev_state_update()=
/
>   - v1 (from RFC):
>     - Fixed typo "occurred"
>     - Changed Kconfig option name and description
>     - Removed comment in the Makefile
>     - Renamed exported function name s/debugfs/debug/
>     - Replaced thermal_debug_cdev_[unregister|register] by [add|remove]
> ---

