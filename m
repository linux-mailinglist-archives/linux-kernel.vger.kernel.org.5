Return-Path: <linux-kernel+bounces-122357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD6388F599
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 03:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15A5D28C136
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD41219F0;
	Thu, 28 Mar 2024 02:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VY8zdp9Y"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A52EA92E;
	Thu, 28 Mar 2024 02:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711594474; cv=none; b=iJyZ3qAvbOymBczCGRgbqX8t71b3fnKkzbRiWqMk/G6iYWvPmi1iVSYgcD498eilqZeqPPLPcyIrCz8S8H42SKiM7mrQ1lf4qtImpQ+91M68iCPVlRwuL5+rpAYtaH63JA+yuMJDpBvMFKTKrNDa5kZ9oKCQBo5pABlsNl+8KVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711594474; c=relaxed/simple;
	bh=x1vicRttReVQaRAZK6DUeyCJxvjby4y7LMMH1N96Exw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tQs+3EWXTi4hDoUD/nHNlFTin0HM93IbwruUy3gaoYkA/GR+R6tyyOHmyoogxHiTrtRktPnV9JL+lrSWbBXHb+wxiMT4G/9UZ2GSg5AJmoLMR7v+E59fLWpIZj2OkhKya+EEhKuaW25F3QV3jWtZEXVf7U2BVzSl4YW0ErBuT48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VY8zdp9Y; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711594472; x=1743130472;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=x1vicRttReVQaRAZK6DUeyCJxvjby4y7LMMH1N96Exw=;
  b=VY8zdp9YD4Mu8ZiER47UkPK93uJ9Ec0Xxtk3JG0r8ZxeI7ZieTxWjQnW
   ltgMF5zfkuBj33Qw5qRBuUS5PPyMircLdXpDt87tnAn/julHAGEJ4IY3J
   X5jFJRjL1uvq56U7zg4xaZMtYr4NGkCRc1c7UB1BvzKcqk3UnNLc+WFNh
   DOzSZVRUiIDODypVmpAHOZfQEI5xud4DO2L2xF1UgCVXtFxMlsTEp9TLc
   AypwgSI41ySuJXiF2YCF15HsEhmSKhxiIRX2WGsZug72an4jeAbxqTjf6
   h0n+l+jaBeacJAgYkAWISaIVj9CE31dDO/ZDgDo8gwKt8X7ThgXne+2Rg
   w==;
X-CSE-ConnectionGUID: XxbVFemBRrWJcQ7ZTO0zTw==
X-CSE-MsgGUID: EWEqyudIToqQ+JjJ1wlVNQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6593632"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="6593632"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 19:54:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="21183044"
Received: from soralee-mobl1.amr.corp.intel.com (HELO [10.255.228.178]) ([10.255.228.178])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 19:54:31 -0700
Message-ID: <8535c887-74bd-4b9a-9978-577b8fd0e289@linux.intel.com>
Date: Wed, 27 Mar 2024 19:54:30 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] platform/x86: wmi: Add driver development guide
Content-Language: en-US
To: Armin Wolf <W_Armin@gmx.de>, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com
Cc: corbet@lwn.net, linux-doc@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240328012336.145612-1-W_Armin@gmx.de>
 <20240328012336.145612-4-W_Armin@gmx.de>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240328012336.145612-4-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 3/27/24 6:23 PM, Armin Wolf wrote:
> Since 2010, an LWN article covering WMI drivers exists:
>
> 	https://lwn.net/Articles/391230/
>
> Since the introduction of the modern bus-based interface
> and other userspace tooling (bmfdec, lswmi, ...), this
> article is outdated and causes people to still submit new
> WMI drivers using the deprecated GUID-based interface.
> Fix this by adding a short guide on how to develop WMI drivers
> using the modern bus-based interface.
>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  .../wmi/driver-development-guide.rst          | 173 ++++++++++++++++++
>  Documentation/wmi/index.rst                   |   1 +
>  2 files changed, 174 insertions(+)
>  create mode 100644 Documentation/wmi/driver-development-guide.rst
>
> diff --git a/Documentation/wmi/driver-development-guide.rst b/Documentation/wmi/driver-development-guide.rst
> new file mode 100644
> index 000000000000..9a1b0a8490bb
> --- /dev/null
> +++ b/Documentation/wmi/driver-development-guide.rst
> @@ -0,0 +1,173 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +============================
> +WMI driver development guide
> +============================
> +
> +The WMI subsystem provides a rich driver API for implementing WMI drivers,
> +documented at Documentation/driver-api/wmi.rst. This document will serve
> +as an introductory guide for WMI driver writers using this API. It is supposed
> +to be an successor to the original `LWN article <https://lwn.net/Articles/391230/>`_

/s/an successor/a successor

IMO, you don't have to refer to lwn article here. You can add it at the bottom
under a references section.

References
==========

https://lwn.net/Articles/391230/>



> +which deals with WMI drivers using the deprecated GUID-based WMI interface.
> +
> +Obtaining WMI device information
> +--------------------------------
> +
> +Before developing an WMI driver, information about the WMI device in question
> +must be obtained. The `lswmi <https://pypi.org/project/lswmi>`_ utility can be
> +used to display detailed WMI device information using the following command:

Instead of display, I think "extract" or "get the " usage will be better.

> +
> +::
> +
> +  lswmi -V
> +
> +The resulting output will contain information about all WMI devices available on
> +a given machine, plus some extra information.
> +
> +In order to find out more about the interface used to communicate with a WMI device,
> +the `bmfdec <https://github.com/pali/bmfdec>`_ utilities can be used to decode
> +the Binary MOF (Managed Object Format) information used to describe WMI devices.
> +The ``wmi-bmof`` driver exposes this information to userspace, see
> +Documentation/wmi/devices/wmi-bmof.rst.
> +
> +In order to retrieve the decoded Binary MOF information, use the following command (requires root):
> +
> +::
> +
> +  ./bmf2mof /sys/bus/wmi/devices/05901221-D566-11D1-B2F0-00A0C9062910[-X]/bmof
> +
> +Sometimes, looking at the disassembled ACPI tables used to describe the WMI device
> +helps in understanding how the WMI device is supposed to work. The path of the ACPI
> +method associated with a given WMI device can be retrieved using the ``lswmi`` utility
> +as mentioned above.
> +
> +Basic WMI driver structure
> +--------------------------
> +
> +The basic WMI driver is build around the struct wmi_driver, which is then bound
> +to matching WMI devices using a struct wmi_device_id table:
> +
> +::
> +
> +  static const struct wmi_device_id foo_id_table[] = {
> +         { "936DA01F-9ABD-4D9D-80C7-02AF85C822A8", NULL },
> +         { }
> +  };
> +  MODULE_DEVICE_TABLE(wmi, foo_id_table);
> +
> +  static struct wmi_driver foo_driver = {
> +        .driver = {
> +                .name = "foo",
> +                .probe_type = PROBE_PREFER_ASYNCHRONOUS,        /* recommended */
> +                .pm = pm_sleep_ptr(&foo_dev_pm_ops),            /* optional */
> +        },
> +        .id_table = foo_id_table,
> +        .probe = foo_probe,
> +        .remove = foo_remove,         /* optional, devres is preferred */
> +        .notify = foo_notify,         /* optional, for event handling */
> +        .no_notify_data = true,       /* optional, enables events containing no additional data */
> +        .no_singleton = true,         /* required for new WMI drivers */
> +  };
> +  module_wmi_driver(foo_driver);
> +
> +The probe() callback is called when the WMI driver is bound to a matching WMI device. Allocating
> +driver-specific data structures and initialising interfaces to other kernel subsystems should
> +normally be done in this function.
> +
> +The remove() callback is then called when the WMI driver is unbound from a WMI device. In order
> +to unregister interfaces to other kernel subsystems and release resources, devres should be used.
> +This simplifies error handling during probe and often allows to omit this callback entirely, see
> +Documentation/driver-api/driver-model/devres.rst for details.
> +
> +Please note that new WMI drivers are required to be able to be instantiated multiple times,
> +and are forbidden from using any deprecated GUID-based WMI functions. This means that the
> +WMI driver should be prepared for the scenario that multiple matching WMI devices are present
> +on a given machine.
> +
> +Because of this, WMI drivers should use the state container design pattern as described in
> +Documentation/driver-api/driver-model/design-patterns.rst.
> +
> +WMI method drivers
> +------------------
> +
> +WMI drivers can call WMI device methods using wmidev_evaluate_method(), the
> +structure of the ACPI buffer passed to this function is device-specific and usually
> +needs some tinkering to get right. Looking at the ACPI tables containing the WMI
> +device usually helps here. The method id and instance number passed to this function
> +are also device-specific, looking at the decoded Binary MOF is usually enough to
> +find the right values.
> +
> +The maximum instance number can be retrieved during runtime using wmidev_instance_count().
> +
> +Take a look at drivers/platform/x86/inspur_platform_profile.c for an example WMI method driver.
> +
> +WMI data block drivers
> +----------------------
> +
> +WMI drivers can query WMI device data blocks using wmidev_block_query(), the
> +structure of the returned ACPI object is again device-specific. Some WMI devices
> +also allow for setting data blocks using wmidev_block_set().
> +
> +The maximum instance number can also be retrieved using wmidev_instance_count().
> +
> +Take a look at drivers/platform/x86/intel/wmi/sbl-fw-update.c for an example
> +WMI data block driver.
> +
> +WMI event drivers
> +-----------------
> +
> +WMI drivers can receive WMI events by providing the notify() callback inside the struct wmi_driver.

IMO /s/providing/via the is better.

> +The WMI subsystem will then take care of setting up the WMI event accordingly. Please note that
> +the structure of the ACPI object passed to this callback is device-specific, and freeing the
> +ACPI object is being done by the WMI subsystem, not the driver.
> +
> +The WMI driver core will take care that the notify() callback will only be called after
> +the probe() callback has been called, and that no events are being received by the driver
> +right before and after calling its remove() callback.
> +
> +However WMI driver developers should be aware that multiple WMI events can be received concurrently,
> +so any locking (if necessary) needs to be provided by the WMI driver itself.

I think locking is needed always for notify handler right?

> +
> +In order to be able to receive WMI events containg no additional event data,

/s/containg/containing

> +the ``no_notify_data`` flag inside struct wmi_driver should be set to ``true``.
> +
> +Take a look at drivers/platform/x86/xiaomi-wmi.c for an example WMI event driver.
> +
> +Handling multiple WMI devices at once
> +-------------------------------------
> +
> +There are many cases of firmware vendors using multiple WMI devices to control different aspects
> +of a single physical device. This can make developing WMI drivers complicated, as those drivers
> +might need to communicate with each other to present a unified interface to userspace.
> +
> +On such case involves a WMI event device which needs to talk to a WMI data block device or WMI
> +method device upon receiving an WMI event. In such a case, two WMI drivers should be developed,
> +one for the WMI event device and one for the other WMI device.
> +
> +The WMI event device driver has only one purpose: to receive WMI events, validate any additional
> +event data and invoke a notifier chain. The other WMI driver adds itself to this notifier chain
> +during probing and thus gets notified every time a WMI event is received. This WMI driver might
> +then process the event further for example by using an input device.
> +
> +For other WMI device constellations, similar mechanisms can be used.
> +
> +Things to avoid
> +---------------
> +
> +When developing WMI drivers, there are a couple of things which should be avoided:
> +
> +- usage of the deprecated GUID-based WMI interface which uses GUIDs instead of WMI device structs
> +- bypassing of the WMI subsystem when talking to WMI devices
> +- WMI drivers which cannot be instantiated multiple times.
> +
> +Many older WMI drivers violate one or more points from this list. The reason for
> +this is that the WMI subsystem evolved significantly over the last two decades,
> +so there is a lot of legacy cruft inside older WMI drivers.
> +
> +New WMI drivers are also required to conform to the linux kernel coding style as specified in
> +Documentation/process/coding-style.rst. The checkpatch utility can catch many common coding style
> +violations, you can invoke it with the following command:
> +
> +::
> +
> +  ./scripts/checkpatch.pl --strict <path to driver file>
> diff --git a/Documentation/wmi/index.rst b/Documentation/wmi/index.rst
> index 537cff188e14..fec4b6ae97b3 100644
> --- a/Documentation/wmi/index.rst
> +++ b/Documentation/wmi/index.rst
> @@ -8,6 +8,7 @@ WMI Subsystem
>     :maxdepth: 1
>
>     acpi-interface
> +   driver-development-guide
>     devices/index
>
>  .. only::  subproject and html
> --
> 2.39.2
>
>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


