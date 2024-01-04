Return-Path: <linux-kernel+bounces-17336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D07FB824BE2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 00:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38D331F22AB0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 23:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A022D600;
	Thu,  4 Jan 2024 23:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfNiZulm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951112D602;
	Thu,  4 Jan 2024 23:37:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B0EDC433C8;
	Thu,  4 Jan 2024 23:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704411459;
	bh=/qOBa2AZb+JmGECPnbX4BaYAV6YEKHPYC5ieuyCr7vw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jfNiZulmkXiF8arUxMubc0AEpgjFvR/lpT0YhvU6GxkxSpar5Dy4Bj8I5CUEu/7KZ
	 KYIpVDhZzEq/aH/t/XPnngaQYDOG62OcAHrrWOhPvSkzJZBz3DznTwCeLBsRKaGS8R
	 A5swp81RYXpHJc6MshO6GDtlRM/kbE4Fs14M9RE4nXMBucspoOJnuhbcN26hYjq3c0
	 ryAlqP7IwBZXF9s3ejyFQF2uoDGBNekaWvOGVomhqMpKGs1H4yDhIwmUSB6SVXr6dZ
	 estorRzCFa2Cq+xQYkKVtQzwjO9WWXj9b1ptvP9oxNTN3/EVvS2rHqT7QqO9zoBHQ+
	 qQPqCBJu9s9uQ==
Date: Fri, 5 Jan 2024 00:37:34 +0100
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, Randy Dunlap
 <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] scripts/get_abi.pl: ignore some temp files
Message-ID: <20240105003734.5b679081@coco.lan>
In-Reply-To: <87o7e15bwk.fsf@meer.lwn.net>
References: <20231228233113.5218-1-rdunlap@infradead.org>
	<87plyi86zg.fsf@meer.lwn.net>
	<87v889z7h3.fsf@intel.com>
	<871qax6t6k.fsf@meer.lwn.net>
	<87o7e15bwk.fsf@meer.lwn.net>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 04 Jan 2024 08:57:47 -0700
Jonathan Corbet <corbet@lwn.net> escreveu:

> Jonathan Corbet <corbet@lwn.net> writes:
> 
> > Jani Nikula <jani.nikula@linux.intel.com> writes:
> >  
> >> On Wed, 03 Jan 2024, Jonathan Corbet <corbet@lwn.net> wrote:  
> >>> It would have been nice to create all of those files with a .abi
> >>> extension so we didn't have to do this kind of blocklisting, but so be
> >>> it.  
> >>
> >> Alternatively, we could switch to yaml instead of using another homebrew
> >> format with another homebrew parser, and rename them .yaml.  
> >
> > But ... we didn't invent that! :)
> >
> > That is, of course, a better idea.  It would be a good project for
> > somebody.  
> 
> Thinking about this a bit further ... is there anything other than
> get_abi.pl that parses these files?

AFAIKT, only get_abi.pl parses them inside the Kernel. 


> If so, that would, of course,
> complicate a switch to YAML.
> 
> If not, though ... and if we're changing the format ... maybe we should
> just turn them into RST and do away with the extra processing step
> entirely?

I don't think it is wise to just convert it to ReST. See, the script
has 4 modes of operation controlled via command line argument[1]:

            search SEARCH_REGEX - search for SEARCH_REGEX inside ABI

            rest - output the ABI in ReST markup language

            validate - validate the ABI contents

            undefined - existing symbols at the system that aren't defined at
            Documentation/ABI

[1] see:
	./get_abi.pl --man

The "rest" command line is used when building the docs. There are also
"search" used if one wants to get the documentation of a particular
sysfs symbol:

	$ scripts/get_abi.pl search nonfatal_errors

	/sys/bus/platform/devices/dfl-fme.0/errors/nonfatal_errors
	----------------------------------------------------------

	Kernel version:		5.4
	Date:			August 2019
	Contact:		Wu Hao <hao.wu@intel.com>
	Defined on file(s):	Documentation/ABI/testing/sysfs-platform-dfl-fme

	Description:

	Read-only. It returns non-fatal errors detected.

Which is useful if a system admin wants to search for some specific
uABI symbol.

The "validate" is similar to the "quiet" mode of kernel-doc: it
just checks if all entries parse OK. If everything is OK, it prints
nothing.

There's also "undefined" (my favorite one when I'm checking for
doc problems on uABI), meaning to detect documentation gaps:

	$ scripts/get_abi.pl undefined --search-string drm/card1|perl -ne 'print "\t$_"'
	Reading /sys directory contents...done.
	Converting ABI What fields into regexes...done.
	0:37: processing sysfs files... 46%: /sys/devices/pci0000:00/0000:00:14.0/usb1/1-10/1-10.4/1-10.4.2/1-10.4.2:1.2/0003:046D:C52B.0003/0003:046D:406A.0004/input/input31/input31::kana/power/aut0:47: processing sysfs files... done
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/gt/gt0/.defaults/rps_max_freq_mhz not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/gt_RP1_freq_mhz not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/card1-HDMI-A-3/connector_id not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/gt/gt0/.defaults/rps_min_freq_mhz not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/gt_min_freq_mhz not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/gt/gt0/rps_max_freq_mhz not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/gt_RPn_freq_mhz not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/gt/gt0/rps_cur_freq_mhz not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/metrics/f889f8cc-4c93-4ac8-b75f-551c0b9b87f7/id not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/gt_max_freq_mhz not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/gt_act_freq_mhz not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/gt_boost_freq_mhz not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/error not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/gt/gt0/rps_min_freq_mhz not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/gt_cur_freq_mhz not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/gt/gt0/punit_req_freq_mhz not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/gt_RP0_freq_mhz not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/gt/gt0/id not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/gt/gt0/rps_up_threshold_pct not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/gt/gt0/rps_act_freq_mhz not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/gt/gt0/rc6_enable not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/gt/gt0/rps_boost_freq_mhz not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/gt/gt0/rps_RP0_freq_mhz not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/gt/gt0/rps_RPn_freq_mhz not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/gt/gt0/rps_RP1_freq_mhz not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/gt/gt0/rc6_residency_ms not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/gt/gt0/rps_down_threshold_pct not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/gt/gt0/.defaults/rps_up_threshold_pct not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/card1-HDMI-A-3/edid not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/gt/gt0/.defaults/rps_down_threshold_pct not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/card1-HDMI-A-3/modes not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/card1-HDMI-A-3/enabled not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/card1-HDMI-A-3/dpms not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/card1-HDMI-A-3/status not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/metrics/398a4268-ef6f-4ffc-b55f-3c7b5363ce61/id not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/metrics/12994724-3a5a-4303-bb3c-ba0175d2c200/id not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/metrics/3addf8ef-8e9b-40f5-a448-3dbb5d5128b0/id not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/metrics/6c66fe6e-2988-454a-bfae-7fca3bbcbec2/id not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/metrics/6d344efd-8e9e-42d4-a29e-1011c29f82c2/id not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/metrics/4af0400a-81c3-47db-a6b6-deddbd75680e/id not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/metrics/9eaf384d-8f53-41b8-a71d-108308780fbc/id not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/metrics/f9954679-a055-4862-9f57-9d66e3ebf81c/id not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/metrics/fb149d66-fad2-4230-b0d7-4d689b9116d3/id not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/metrics/d7a17a3a-ca71-40d2-a919-ace80d50633f/id not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/metrics/e3b386ae-c195-47d5-af29-8a1afa0ae2bf/id not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/metrics/57b59202-172b-477a-87de-33f85572c589/id not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/metrics/0e22f995-79ca-4f67-83ab-e9d9772488d8/id not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/metrics/99c1a40e-a090-4354-86e3-4d068bb1917e/id not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/metrics/cd4b577b-073a-423f-a948-e198dd818c71/id not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/metrics/4032137b-8dcc-4f3f-912d-c0bb14a123bc/id not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/metrics/a00cbdf2-eabd-4240-9a89-86e2ac1ca1e4/id not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/metrics/b49aa434-4958-4d98-9e6f-443ff27ca74d/id not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/metrics/aa7a3fb9-22fb-43ff-a32d-0ab6c13bbd16/id not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/metrics/4ed5e27e-fd1a-4f11-ad8f-9374e128c697/id not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/card1-HDMI-A-1/connector_id not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/card1-HDMI-A-1/edid not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/card1-HDMI-A-1/enabled not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/card1-HDMI-A-1/modes not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/card1-HDMI-A-1/dpms not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/card1-HDMI-A-1/status not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/card1-DP-2/edid not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/card1-DP-2/status not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/card1-DP-2/enabled not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/card1-DP-2/dpms not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/card1-DP-2/connector_id not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/card1-DP-2/modes not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/card1-DP-2/i2c-7/new_device not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/power/rc6_residency_ms not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/card1-DP-2/drm_dp_aux1/name not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/card1-DP-2/i2c-7/name not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/vecs0/.defaults/heartbeat_interval_ms not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/card1-DP-2/i2c-7/delete_device not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/power/rc6_enable not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/vcs0/.defaults/heartbeat_interval_ms not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/vecs0/heartbeat_interval_ms not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/vecs0/stop_timeout_ms not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/vecs0/max_busywait_duration_ns not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/vecs0/instance not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/bcs0/.defaults/heartbeat_interval_ms not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/rcs0/.defaults/heartbeat_interval_ms not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/vecs0/capabilities not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/vecs0/.defaults/stop_timeout_ms not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/vcs0/known_capabilities not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/vecs0/timeslice_duration_ms not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/vecs0/known_capabilities not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/vecs0/class not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/vecs0/preempt_timeout_ms not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/vecs0/mmio_base not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/vecs0/name not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/vecs0/.defaults/max_busywait_duration_ns not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/vcs0/heartbeat_interval_ms not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/vecs0/.defaults/timeslice_duration_ms not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/vcs0/stop_timeout_ms not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/vecs0/.defaults/preempt_timeout_ms not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/vcs0/max_busywait_duration_ns not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/vcs0/capabilities not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/vcs0/instance not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/vcs0/.defaults/stop_timeout_ms not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/bcs0/known_capabilities not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/vcs0/timeslice_duration_ms not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/vcs0/class not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/vcs0/preempt_timeout_ms not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/vcs0/mmio_base not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/vcs0/name not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/vcs0/.defaults/max_busywait_duration_ns not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/bcs0/heartbeat_interval_ms not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/vcs0/.defaults/timeslice_duration_ms not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/bcs0/stop_timeout_ms not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/vcs0/.defaults/preempt_timeout_ms not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/bcs0/max_busywait_duration_ns not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/bcs0/capabilities not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/bcs0/instance not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/bcs0/.defaults/stop_timeout_ms not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/rcs0/known_capabilities not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/bcs0/timeslice_duration_ms not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/bcs0/class not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/bcs0/preempt_timeout_ms not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/bcs0/mmio_base not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/bcs0/name not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/bcs0/.defaults/max_busywait_duration_ns not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/rcs0/heartbeat_interval_ms not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/bcs0/.defaults/timeslice_duration_ms not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/rcs0/stop_timeout_ms not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/bcs0/.defaults/preempt_timeout_ms not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/rcs0/max_busywait_duration_ns not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/rcs0/capabilities not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/rcs0/instance not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/rcs0/.defaults/stop_timeout_ms not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/rcs0/timeslice_duration_ms not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/rcs0/class not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/rcs0/preempt_timeout_ms not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/rcs0/mmio_base not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/rcs0/name not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/card1-HDMI-A-2/edid not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/rcs0/.defaults/max_busywait_duration_ns not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/card1-HDMI-A-2/connector_id not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/rcs0/.defaults/timeslice_duration_ms not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/engine/rcs0/.defaults/preempt_timeout_ms not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/card1-HDMI-A-2/enabled not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/card1-HDMI-A-2/modes not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/card1-HDMI-A-2/dpms not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/card1-HDMI-A-2/status not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/card1-DP-1/edid not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/card1-DP-1/status not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/card1-DP-1/enabled not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/card1-DP-1/i2c-6/new_device not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/card1-DP-1/dpms not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/card1-DP-1/connector_id not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/card1-DP-1/modes not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/card1-DP-1/i2c-6/name not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/card1-DP-1/i2c-6/delete_device not found.
	/sys/devices/pci0000:00/0000:00:02.0/drm/card1/card1-DP-1/drm_dp_aux0/name not found.

It helps a lot to check if the uABI entries are properly pointing to
the right sysfs nodes, being really useful when someone is documenting
the uABI and to check for gaps. My original goal were to run it at
build time, but currently there are too many gaps for it to be useful:

	$ scripts/get_abi.pl undefined|wc -l
	Reading /sys directory contents...done.
	Converting ABI What fields into regexes...done.
	5:08: processing sysfs files... 46%: /sys/devices/pci0000:00/0000:00:14.0/usb1/1-10/1-10.4/1-10.4.2/1-10.4.2:1.2/0003:046D:C52B.0003/0003:046D:406A.0004/hidraw/hidraw1/power/runtime_suspende10:32: processing sysfs files... done
	4910

(this is on my laptop - Running it on a server reports 50k-100k missing
symbols)

It would be ok to convert ABI to use YAML or ReST if we can ensure that
we'll keep supporting symbol search and undefined uAPI detection.

Yet, IMO, using ReST directly for ABI could be problematic if people
don't add uABI symbols on a "database-like" parseable series of files.

In any case, if we convert it to YAML or ReST, we can modify the
ABI parser and/or scripts/checkpatch.pl to validate if:

	- the uAPI is properly documented with the expected fields,
	  as described under Documentation/ABI/README;
	- there are uAPI gaps;
	- there won't be duplicated documentation for the same 
	  uAPI symbol.

Thanks,
Mauro

