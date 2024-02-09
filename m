Return-Path: <linux-kernel+bounces-60043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA0C84FF06
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A7091F23449
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF7F21362;
	Fri,  9 Feb 2024 21:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="YjGlBYXr"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC9B21345
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 21:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707514695; cv=none; b=eE04Kofpxih0H8lM4qAGn7SG+sHtbtxOPwQ6OGYtt7OUH7gh+WJ9vf7iMiOb52UaTpIVXFq5NlI7JlB2laCusb0gm+h0vrTz5rO8wJRbadRPiHt8udS3hCZv8YYrR2qlkRDJKoW6lDe0r8YXVK0vs0ifeGfXhLdPXU5Uf25uAG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707514695; c=relaxed/simple;
	bh=VMCz8O3uEXO4bC54yXRW/u3Prkn+dR8NrfSUwRHRXNY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bqnANAB2AqT8cypHF3GtzGGugY/16JG68eEWR+1EmFQTffkktaHRS34DnEK+KAI/ldjDd8sB34kERgoQRMUyVYU+dMcZDrmrsR7sdrUtFWP7eX5RXQZPc4yqXSTagyiln4MjIl+Woaq7pkeG+7KzLlPvFBq+f3zXJ4Rj/ui8ofE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net; spf=pass smtp.mailfrom=telus.net; dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b=YjGlBYXr; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d7393de183so11581975ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 13:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1707514692; x=1708119492; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3Gn35MQPFitK/RkErnBz6AmQLFmvJyKpC3m6ymwsMYo=;
        b=YjGlBYXrw38QRhYirbjYreZryqciu81AWOluL3b0F7lxAvTNyN65/W2ZqCcHrci2Hu
         tKPXCTMUbUQHE4EeJtcuwT8bPPGhXmsZBtrgm3Xb/P5UskGiUe1z0oySr2U6ulaG7AwP
         rhxTzQI052A39fIzVk1TFiLZNLKDvV2vRYzQjcoszkdv1But0PlJE3PHrhEfipE2kTVQ
         edS08g1RG+YK0V6kBnqWxz9ARvj5MZaTJsXLwuM+SKobDrtnXEcHN2t90Ttu4w035qr8
         g7+USz2OPUpC5ZcwHkSPL06UAev/XtVFYdCikuv/1/1gZtW7xd1HZtyCjaU3YMQOmjQe
         DFOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707514692; x=1708119492;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Gn35MQPFitK/RkErnBz6AmQLFmvJyKpC3m6ymwsMYo=;
        b=cJahfBivtIg8P53zZfP43rZG6A6FVHNCaMO7b2CKjy9Jv5YVG1xzck+9olmDB5Wjmd
         DFDVH30vER0slWxBXKqrKdawcXBn4XfiEme6Pk1xshJ2flhKkimDOSMAp20rIwTH7Gew
         G/D5EgbKbdhU0dpZLMx98PSZzdIERRhg7wXcLkJ5O//5Wxgqnb45A+hW5DdjOMZ3xBxT
         s6BEeMzvl4zbjlcWdp7ARVTPNWOphIQtghnjvXgfE05akrSnugowfoLwDiv/b+dOpF3U
         qJH1oE1Anq6ok5Nm/VlmDnk/JImjnBpexNGHsQVpTIhvq6CT10U8KhbrUlRVaKidAGBW
         Vi1Q==
X-Gm-Message-State: AOJu0Yz/CKP7klH/Ae+GW0AU1uPGGhISVynsQIxXSRqo9m6v5oU3UnKl
	r+gXcEO8c3kwQUY3Blrz8hbKo7gfQNu8OcEc2sFO8bUpJanT+a6rsgEn2yGPq0M=
X-Google-Smtp-Source: AGHT+IHZiIoJhTIlf6Z/TAkUtq1febjHN+ZiTHR+u2eS/63Mz8GtyS137SCPx2c37UyumtTZ3OJ5Vg==
X-Received: by 2002:a17:903:2448:b0:1d9:1cb5:558b with SMTP id l8-20020a170903244800b001d91cb5558bmr452175pls.15.1707514692488;
        Fri, 09 Feb 2024 13:38:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUmTkwkSKpr7cQ3KShselWIGQkGdjDq3IJX6BbybkJjbr7m+EIiurn11xe+lWgtCdOXt1d5/NR48XyVCKo8iEbLbdyRMlGI/QXX9QAUEPKtyvUwsHrqy5NTOVYQ4PreNU0tLh+ZCxaPGwXC5jCVbO9OjV6AYRuklahVqfhB3LmsGdi6ZiDC9g==
Received: from DougS18 (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id li8-20020a170903294800b001d97fe26d47sm1957350plb.34.2024.02.09.13.38.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2024 13:38:12 -0800 (PST)
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Vincent Guittot'" <vincent.guittot@linaro.org>,
	"'Ingo Molnar'" <mingo@kernel.org>,
	"'Rafael J. Wysocki'" <rafael@kernel.org>
Cc: <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	"Doug Smythies" <dsmythies@telus.net>
Subject: sched/cpufreq: Rework schedutil governor performance estimation - Regression bisected
Date: Fri, 9 Feb 2024 13:38:14 -0800
Message-ID: <002f01da5ba0$49cbf810$dd63e830$@telus.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AdpbnQo3jI2AMWzRTQGA64jOQdUYtg==

Hi,

I noticed a regression in the 6.8rc series kernels. Bisecting the kernel pointed to:

# first bad commit: [9c0b4bb7f6303c9c4e2e34984c46f5a86478f84d]
sched/cpufreq: Rework schedutil governor performance estimation

There was previous bisection and suggestion of reversion,
but I guess it wasn't done in the end. [1]

The regression: reduced maximum CPU frequency is ignored.

Conditions:
CPU frequency scaling driver: intel_cpufreq (a.k.a intel_pstate in passive mode)
CPU frequency scaling governor: schedutil
HWP (HardWare Pstate) control (a.k.a. Intel_speedshift): Enabled
Processor: Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz

I did not check any other conditions, i.e. HWP disabled or the acpi-cpufreq driver.

Example: A 100% load on CPU 5.

sudo turbostat --quiet --Summary --show Busy%,Bzy_MHz,IRQ,PkgWatt,PkgTmp,RAMWatt,GFXWatt,CorWatt --interval 15
Busy%   Bzy_MHz IRQ     PkgTmp  PkgWatt CorWatt GFXWatt RAMWatt
8.42    4636    21823   67      28.40   27.56   0.00    2.59
8.40    4577    17724   66      27.57   26.73   0.00    2.59
8.35    4637    19535   66      28.65   27.81   0.00    2.60
8.41    4578    20723   66      27.73   26.89   0.00    2.59
8.40    4558    19156   67      27.39   26.55   0.00    2.58
8.34    4502    18127   67      26.79   25.96   0.00    2.57

grep . /sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq
/sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq:2400000
/sys/devices/system/cpu/cpu10/cpufreq/scaling_max_freq:2400000
/sys/devices/system/cpu/cpu11/cpufreq/scaling_max_freq:2400000
/sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq:2400000
/sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq:2400000
/sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq:2400000
/sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq:2400000
/sys/devices/system/cpu/cpu5/cpufreq/scaling_max_freq:2400000
/sys/devices/system/cpu/cpu6/cpufreq/scaling_max_freq:2400000
/sys/devices/system/cpu/cpu7/cpufreq/scaling_max_freq:2400000
/sys/devices/system/cpu/cpu8/cpufreq/scaling_max_freq:2400000
/sys/devices/system/cpu/cpu9/cpufreq/scaling_max_freq:2400000

grep . /sys/devices/system/cpu/cpu5/cpufreq/*
/sys/devices/system/cpu/cpu5/cpufreq/affected_cpus:5
/sys/devices/system/cpu/cpu5/cpufreq/base_frequency:4100000
/sys/devices/system/cpu/cpu5/cpufreq/cpuinfo_max_freq:4800000
/sys/devices/system/cpu/cpu5/cpufreq/cpuinfo_min_freq:800000
/sys/devices/system/cpu/cpu5/cpufreq/cpuinfo_transition_latency:20000
/sys/devices/system/cpu/cpu5/cpufreq/energy_performance_available_preferences:default performance balance_performance balance_power
power
/sys/devices/system/cpu/cpu5/cpufreq/energy_performance_preference:balance_performance
/sys/devices/system/cpu/cpu5/cpufreq/related_cpus:5
/sys/devices/system/cpu/cpu5/cpufreq/scaling_available_governors:conservative ondemand userspace powersave performance schedutil
/sys/devices/system/cpu/cpu5/cpufreq/scaling_cur_freq:4799998
/sys/devices/system/cpu/cpu5/cpufreq/scaling_driver:intel_cpufreq
/sys/devices/system/cpu/cpu5/cpufreq/scaling_governor:schedutil
/sys/devices/system/cpu/cpu5/cpufreq/scaling_max_freq:2400000
/sys/devices/system/cpu/cpu5/cpufreq/scaling_min_freq:800000
/sys/devices/system/cpu/cpu5/cpufreq/scaling_setspeed:<unsupported>

[1] https://lore.kernel.org/all/CAKfTPtDCQuJjpi6=zjeWPcLeP+ZY5Dw7XDrZ-LpXqEAAUbXLhA@mail.gmail.com/



