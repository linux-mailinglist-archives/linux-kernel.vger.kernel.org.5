Return-Path: <linux-kernel+bounces-62381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1792851F78
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 143371F223EA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BB54CB3D;
	Mon, 12 Feb 2024 21:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="hJP1UmtK"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7958143AA8
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 21:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707772868; cv=none; b=GDXnFVoY5j7Sr2xKMqCxYajyO0kxZOIOHltLNIXrOYJ+/hIY3tOeIDHspCY8AeVXFfuwaWRrcWvAq6eJoHmHTEHuy0mSLLpekDcqNsMpA/SYSKS416oEybf72OoarxDjVgFaXnx3p98cR9M5BSAHS8koMiMB5cQePa0lQ5Yhgr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707772868; c=relaxed/simple;
	bh=sugQKZ6CI31VxqP/5rNr26Vx+C48PCffDxNO4koQ3p0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bBYs8L4ep+Og7RK9PvrBmBbYd+jT+dZMUy3CMWEbV9bVGPtsm0cw93pzBtzvJ8n2fsS5kUe12bhgw4mAn8ZaQjHgdi72RGn3JA6QpbutgPvcFes7/2wb9KuOFw0HSaxYL84LqxREdaxXaUxDvBu0AoECrulcbXp1Ad46cy+bjIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=hJP1UmtK; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-46d14b08beaso532119137.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707772865; x=1708377665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ed9q/dTWT4cjCHIaItjeYvOw5uibDZAlFpwB/jaYCCc=;
        b=hJP1UmtKbJ6UhHAM5KsbTTSwIuMrOcvHOpyNPclgO8043hUbpPOWD57oBh04K/43OL
         bedtw5g9u6W7DXw9iVLEEwiaV2+4dHIOvWdmfaeJ3uO/JNatgjCpOWRDlV3p5ZJfAcEB
         TPWfh1ycuqIwHYDdZvtwMH6YOAiojgpANT8g6djbOwGpBmwKOkmOY15peA2zCqV+XDAg
         jnJDu9w+x9XOdvK+d742gYdyX99EFNrnmVvcqb9TaLMJH2ZZencJWT8W5y67xh7N5nTc
         +jeERCuRxy2fb+1MclSXBf76noafiE1KUgiOxzgR/5hYQfEQKPBHRDzpNym7jTQiJeht
         yuow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707772865; x=1708377665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ed9q/dTWT4cjCHIaItjeYvOw5uibDZAlFpwB/jaYCCc=;
        b=rpSawQfoPvtxak1OJ/kQ1UEikegqvayCTz0inz3ArBXT5gy2fvpu2sfYqBA7RDScMz
         0nNRHIom43tLovj3gWw3gS19rQuLFhFlNDM14KVmIayjtyD24AMxYxK9+IeHzQYzCPoS
         dTNGhr2rge+lN8FoVvxJnLV/XRqIzEKmmadykUgj1G4RRV3vMfqEdn2idG5JEDlGuWCy
         3HWzZjkjjnJy8JRtaO+4iPYft+DnZO2Jj2cbCrpzaJqhVAYbGMshFORa23++b7vATe2p
         hXYYqz0qomDzaJ7MvN3FS2hBtN3QrWH2gROgDP5uzTlKPA+jnPdwjlGXCk1U0ApcZjKL
         Af6Q==
X-Gm-Message-State: AOJu0YzHMBXq7Qfa0PuMeLNcku3WsqoRMDlTWY44XgIL/r02eGaseeli
	t9r7f2XJE094b1QrWXNUSFVduhCL0Xn+4VPDMy+za3sZ38AjY7lw7oJzlQ4hb+sYQMem3kYfipf
	eWfnxAqNlYFelk6ahHL3tb/z2UaNJKjJLdL32fQ==
X-Google-Smtp-Source: AGHT+IFRuT42LMQZNy71XtRRfuAVN2Wy0YAglkPguTH63k+w/JX5A4su1DL384yv0Dxy7NLB4XH+ZqE+PxBPKe/aLlA=
X-Received: by 2002:a05:6102:3bc6:b0:46d:3a99:7f0 with SMTP id
 a6-20020a0561023bc600b0046d3a9907f0mr4899104vsv.2.1707772865173; Mon, 12 Feb
 2024 13:21:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208095920.8035-23-brgl@bgdev.pl> <202402122234.d85cca9b-lkp@intel.com>
In-Reply-To: <202402122234.d85cca9b-lkp@intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 12 Feb 2024 22:20:54 +0100
Message-ID: <CAMRc=McrFqa-nS3L0qGZ+eCff79jWrEZLmg-OJiNw6+FQ44i+Q@mail.gmail.com>
Subject: Re: [PATCH v3 22/24] gpio: protect the pointer to gpio_chip in
 gpio_device with SRCU
To: "Paul E . McKenney" <paulmck@kernel.org>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, 
	Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	Kent Gibson <warthog618@gmail.com>, Alex Elder <elder@linaro.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 4:11=E2=80=AFPM kernel test robot <oliver.sang@inte=
l.com> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed "WARNING:suspicious_RCU_usage" on:
>
> commit: c21131f83abc1f7227e7a6d5311e1df68bfa44e0 ("[PATCH v3 22/24] gpio:=
 protect the pointer to gpio_chip in gpio_device with SRCU")
> url: https://github.com/intel-lab-lkp/linux/commits/Bartosz-Golaszewski/g=
pio-protect-the-list-of-GPIO-devices-with-SRCU/20240208-180822
> base: https://git.kernel.org/cgit/linux/kernel/git/brgl/linux.git gpio/fo=
r-next
> patch link: https://lore.kernel.org/all/20240208095920.8035-23-brgl@bgdev=
pl/
> patch subject: [PATCH v3 22/24] gpio: protect the pointer to gpio_chip in=
 gpio_device with SRCU
>
> in testcase: boot
>
> compiler: gcc-12
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 1=
6G
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
> +-----------------------------------------------------------------+------=
------+------------+
> |                                                                 | a3dfc=
11062 | c21131f83a |
> +-----------------------------------------------------------------+------=
------+------------+
> | drivers/gpio/gpiolib.c:#suspicious_rcu_dereference_check()usage | 0    =
      | 8          |
> | drivers/gpio/gpiolib.h:#suspicious_rcu_dereference_check()usage | 0    =
      | 8          |
> +-----------------------------------------------------------------+------=
------+------------+
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202402122234.d85cca9b-lkp@intel.=
com
>
>
>
> [   76.432519][    T1] gpiochip_find_base_unlocked: found new base at 512
> [   76.434591][    T1]
> [   76.435240][    T1] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   76.436545][    T1] WARNING: suspicious RCU usage
> [   76.437813][    T1] 6.8.0-rc1-00050-gc21131f83abc #1 Tainted: G       =
          N
> [   76.439873][    T1] -----------------------------
> [   76.441158][    T1] drivers/gpio/gpiolib.c:219 suspicious rcu_derefere=
nce_check() usage!
> [   76.443364][    T1]
> [   76.443364][    T1] other info that might help us debug this:
> [   76.443364][    T1]
> [   76.446059][    T1]
> [   76.446059][    T1] rcu_scheduler_active =3D 2, debug_locks =3D 1
> [   76.448217][    T1] 1 lock held by swapper/1:
> [ 76.449412][ T1] #0: ffff88816954f0f0 (&dev->mutex){....}-{3:3}, at: __d=
river_attach (drivers/base/dd.c:1216)
> [   76.451938][    T1]
> [   76.451938][    T1] stack backtrace:
> [   76.453486][    T1] CPU: 0 PID: 1 Comm: swapper Tainted: G            =
     N 6.8.0-rc1-00050-gc21131f83abc #1
> [   76.456114][    T1] Call Trace:
> [   76.456936][    T1]  <TASK>
> [ 76.457682][ T1] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1))
> [ 76.458833][ T1] lockdep_rcu_suspicious (include/linux/context_tracking.=
h:153 kernel/locking/lockdep.c:6713)
> [ 76.460205][ T1] gpiod_to_chip (drivers/gpio/gpiolib.c:219 (discriminato=
r 9))
> [ 76.461346][ T1] gpiod_hog (drivers/gpio/gpiolib.h:243 drivers/gpio/gpio=
lib.c:4502)
> [ 76.462400][ T1] ? of_find_property (drivers/of/base.c:223)
> [ 76.463671][ T1] of_gpiochip_add_hog (drivers/gpio/gpiolib-of.c:799)
> [ 76.464933][ T1] ? __pfx_of_gpiochip_add_hog (drivers/gpio/gpiolib-of.c:=
785)
> [ 76.466378][ T1] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c=
:467 kernel/locking/lockdep.c:4360)
> [ 76.467894][ T1] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4423)
> [ 76.469220][ T1] ? _raw_spin_unlock_irqrestore (arch/x86/include/asm/pre=
empt.h:103 include/linux/spinlock_api_smp.h:152 kernel/locking/spinlock.c:1=
94)
> [ 76.470786][ T1] of_gpiochip_add (drivers/gpio/gpiolib-of.c:828 drivers/=
gpio/gpiolib-of.c:1143)
> [ 76.472060][ T1] ? fwnode_property_read_int_array (drivers/base/property=
c:268 (discriminator 5))
> [ 76.473692][ T1] gpiochip_add_data_with_key (drivers/gpio/gpiolib.c:989)
> [ 76.475271][ T1] ? kasan_save_track (arch/x86/include/asm/current.h:42 m=
m/kasan/common.c:60 mm/kasan/common.c:70)
> [ 76.476567][ T1] unittest_gpio_probe (drivers/of/unittest.c:1886)
> [ 76.477928][ T1] platform_probe (drivers/base/platform.c:1404)
> [ 76.479162][ T1] really_probe (drivers/base/dd.c:579 drivers/base/dd.c:6=
58)
> [ 76.480403][ T1] __driver_probe_device (drivers/base/dd.c:800)
> [ 76.481791][ T1] driver_probe_device (drivers/base/dd.c:830)
> [ 76.483097][ T1] __driver_attach (drivers/base/dd.c:1217)
> [ 76.484388][ T1] ? __pfx___driver_attach (drivers/base/dd.c:1157)
> [ 76.485805][ T1] bus_for_each_dev (drivers/base/bus.c:367)
> [ 76.487037][ T1] ? lockdep_init_map_type (kernel/locking/lockdep.c:4892)
> [ 76.488477][ T1] ? __pfx_bus_for_each_dev (drivers/base/bus.c:356)
> [ 76.489897][ T1] ? bus_add_driver (drivers/base/bus.c:672)
> [ 76.491195][ T1] bus_add_driver (drivers/base/bus.c:674)
> [ 76.492463][ T1] driver_register (drivers/base/driver.c:246)
> [ 76.493723][ T1] of_unittest_overlay_gpio (drivers/of/unittest.c:1969 (d=
iscriminator 4))
> [ 76.495167][ T1] of_unittest_overlay (drivers/of/unittest.c:2189 drivers=
/of/unittest.c:3217)
> [ 76.496478][ T1] ? __pfx_of_unittest_overlay (drivers/of/unittest.c:3155=
)
> [ 76.497886][ T1] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c=
:467 kernel/locking/lockdep.c:4360)
> [ 76.499410][ T1] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4423)
> [ 76.500744][ T1] of_unittest (drivers/of/unittest.c:4129)
> [ 76.501862][ T1] ? __pfx_of_unittest (drivers/of/unittest.c:4080)
> [ 76.503098][ T1] ? add_device_randomness (drivers/char/random.c:918)
> [ 76.504492][ T1] ? __pfx_of_unittest (drivers/of/unittest.c:4080)
> [ 76.505807][ T1] do_one_initcall (init/main.c:1236)
> [ 76.507054][ T1] ? __pfx_do_one_initcall (init/main.c:1227)
> [ 76.508517][ T1] do_initcalls (init/main.c:1297 init/main.c:1314)
> [ 76.509731][ T1] kernel_init_freeable (init/main.c:1555)
> [ 76.511106][ T1] ? __pfx_kernel_init (init/main.c:1433)
> [ 76.512435][ T1] kernel_init (init/main.c:1443)
> [ 76.513566][ T1] ? _raw_spin_unlock_irq (arch/x86/include/asm/preempt.h:=
103 include/linux/spinlock_api_smp.h:160 kernel/locking/spinlock.c:202)
> [ 76.514947][ T1] ret_from_fork (arch/x86/kernel/process.c:153)
> [ 76.516125][ T1] ? __pfx_kernel_init (init/main.c:1433)
> [ 76.517440][ T1] ret_from_fork_asm (arch/x86/entry/entry_64.S:250)
> [   76.518731][    T1]  </TASK>
> [   76.519758][    T1]
> [   76.520477][    T1] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   76.521774][    T1] WARNING: suspicious RCU usage
> [   76.523076][    T1] 6.8.0-rc1-00050-gc21131f83abc #1 Tainted: G       =
          N
> [   76.525108][    T1] -----------------------------
> [   76.526429][    T1] drivers/gpio/gpiolib.h:210 suspicious rcu_derefere=
nce_check() usage!
> [   76.528621][    T1]
> [   76.528621][    T1] other info that might help us debug this:
> [   76.528621][    T1]
> [   76.531350][    T1]
> [   76.531350][    T1] rcu_scheduler_active =3D 2, debug_locks =3D 1
> [   76.533414][    T1] 2 locks held by swapper/1:
> [ 76.534616][ T1] #0: ffff88816954f0f0 (&dev->mutex){....}-{3:3}, at: __d=
river_attach (drivers/base/dd.c:1216)
> [ 76.537073][ T1] #1: ffff888163afb6d0 (&gdev->srcu){.+.+}-{0:0}, at: gpi=
od_request_commit (include/linux/srcu.h:116 include/linux/srcu.h:215 driver=
s/gpio/gpiolib.h:202 drivers/gpio/gpiolib.c:2243)
> [   76.539703][    T1]
> [   76.539703][    T1] stack backtrace:
> [   76.541276][    T1] CPU: 0 PID: 1 Comm: swapper Tainted: G            =
     N 6.8.0-rc1-00050-gc21131f83abc #1
> [   76.543890][    T1] Call Trace:
> [   76.544767][    T1]  <TASK>
> [ 76.545549][ T1] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1))
> [ 76.546740][ T1] lockdep_rcu_suspicious (include/linux/context_tracking.=
h:153 kernel/locking/lockdep.c:6713)
> [ 76.548196][ T1] gpiod_request_commit (drivers/gpio/gpiolib.h:202 driver=
s/gpio/gpiolib.c:2243)
> [ 76.549584][ T1] ? dump_stack_lvl (lib/dump_stack.c:108)
> [ 76.550829][ T1] gpiochip_request_own_desc (drivers/gpio/gpiolib.c:2454)
> [ 76.552354][ T1] gpiod_hog (drivers/gpio/gpiolib.c:4504)
> [ 76.553556][ T1] of_gpiochip_add_hog (drivers/gpio/gpiolib-of.c:799)
> [ 76.554948][ T1] ? __pfx_of_gpiochip_add_hog (drivers/gpio/gpiolib-of.c:=
785)
> [ 76.556536][ T1] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c=
:467 kernel/locking/lockdep.c:4360)
> [ 76.558176][ T1] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4423)
> [ 76.559633][ T1] ? _raw_spin_unlock_irqrestore (arch/x86/include/asm/pre=
empt.h:103 include/linux/spinlock_api_smp.h:152 kernel/locking/spinlock.c:1=
94)
> [ 76.561252][ T1] of_gpiochip_add (drivers/gpio/gpiolib-of.c:828 drivers/=
gpio/gpiolib-of.c:1143)
> [ 76.562584][ T1] ? fwnode_property_read_int_array (drivers/base/property=
c:268 (discriminator 5))
> [ 76.564302][ T1] gpiochip_add_data_with_key (drivers/gpio/gpiolib.c:989)
> [ 76.565974][ T1] ? kasan_save_track (arch/x86/include/asm/current.h:42 m=
m/kasan/common.c:60 mm/kasan/common.c:70)
> [ 76.567328][ T1] unittest_gpio_probe (drivers/of/unittest.c:1886)
> [ 76.568780][ T1] platform_probe (drivers/base/platform.c:1404)
> [ 76.570065][ T1] really_probe (drivers/base/dd.c:579 drivers/base/dd.c:6=
58)
> [ 76.571309][ T1] __driver_probe_device (drivers/base/dd.c:800)
> [ 76.572801][ T1] driver_probe_device (drivers/base/dd.c:830)
> [ 76.574175][ T1] __driver_attach (drivers/base/dd.c:1217)
> [ 76.575513][ T1] ? __pfx___driver_attach (drivers/base/dd.c:1157)
> [ 76.576994][ T1] bus_for_each_dev (drivers/base/bus.c:367)
> [ 76.578331][ T1] ? lockdep_init_map_type (kernel/locking/lockdep.c:4892)
> [ 76.579877][ T1] ? __pfx_bus_for_each_dev (drivers/base/bus.c:356)
> [ 76.581368][ T1] ? bus_add_driver (drivers/base/bus.c:672)
> [ 76.582799][ T1] bus_add_driver (drivers/base/bus.c:674)
> [ 76.584128][ T1] driver_register (drivers/base/driver.c:246)
> [ 76.585452][ T1] of_unittest_overlay_gpio (drivers/of/unittest.c:1969 (d=
iscriminator 4))
> [ 76.586969][ T1] of_unittest_overlay (drivers/of/unittest.c:2189 drivers=
/of/unittest.c:3217)
> [ 76.588400][ T1] ? __pfx_of_unittest_overlay (drivers/of/unittest.c:3155=
)
> [ 76.589958][ T1] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c=
:467 kernel/locking/lockdep.c:4360)
> [ 76.591624][ T1] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4423)
> [ 76.593071][ T1] of_unittest (drivers/of/unittest.c:4129)
> [ 76.594323][ T1] ? __pfx_of_unittest (drivers/of/unittest.c:4080)
> [ 76.595700][ T1] ? add_device_randomness (drivers/char/random.c:918)
> [ 76.597164][ T1] ? __pfx_of_unittest (drivers/of/unittest.c:4080)
> [ 76.598482][ T1] do_one_initcall (init/main.c:1236)
> [ 76.599728][ T1] ? __pfx_do_one_initcall (init/main.c:1227)
> [ 76.601163][ T1] do_initcalls (init/main.c:1297 init/main.c:1314)
> [ 76.602389][ T1] kernel_init_freeable (init/main.c:1555)
> [ 76.603810][ T1] ? __pfx_kernel_init (init/main.c:1433)
> [ 76.605101][ T1] kernel_init (init/main.c:1443)
> [ 76.606235][ T1] ? _raw_spin_unlock_irq (arch/x86/include/asm/preempt.h:=
103 include/linux/spinlock_api_smp.h:160 kernel/locking/spinlock.c:202)
> [ 76.607627][ T1] ret_from_fork (arch/x86/kernel/process.c:153)
> [ 76.608797][ T1] ? __pfx_kernel_init (init/main.c:1433)
> [ 76.610112][ T1] ret_from_fork_asm (arch/x86/entry/entry_64.S:250)
> [   76.611412][    T1]  </TASK>
> [   76.612591][    T1] general protection fault, probably for non-canonic=
al address 0xdffffc000000002f: 0000 [#1] PREEMPT KASAN PTI
> [   76.615654][    T1] KASAN: null-ptr-deref in range [0x0000000000000178=
-0x000000000000017f]
> [   76.617847][    T1] CPU: 0 PID: 1 Comm: swapper Tainted: G            =
     N 6.8.0-rc1-00050-gc21131f83abc #1
> [ 76.620463][ T1] RIP: 0010:check_init_srcu_struct (kernel/rcu/srcutree.c=
:408)
> [ 76.622072][ T1] Code: 53 48 89 fb 80 3c 02 00 0f 85 fe 00 00 00 48 b8 0=
0 00 00 00 00 fc ff df 48 8b 6b 38 48 8d bd 78 01 00 00 48 89 fa 48 c1 ea 0=
3 <80> 3c 02 00 0f 85 ce 00 00 00 48 8b 85 78 01 00 00 a8 03 75 0b 5b
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:   53                      push   %rbx
>    1:   48 89 fb                mov    %rdi,%rbx
>    4:   80 3c 02 00             cmpb   $0x0,(%rdx,%rax,1)
>    8:   0f 85 fe 00 00 00       jne    0x10c
>    e:   48 b8 00 00 00 00 00    movabs $0xdffffc0000000000,%rax
>   15:   fc ff df
>   18:   48 8b 6b 38             mov    0x38(%rbx),%rbp
>   1c:   48 8d bd 78 01 00 00    lea    0x178(%rbp),%rdi
>   23:   48 89 fa                mov    %rdi,%rdx
>   26:   48 c1 ea 03             shr    $0x3,%rdx
>   2a:*  80 3c 02 00             cmpb   $0x0,(%rdx,%rax,1)               <=
-- trapping instruction
>   2e:   0f 85 ce 00 00 00       jne    0x102
>   34:   48 8b 85 78 01 00 00    mov    0x178(%rbp),%rax
>   3b:   a8 03                   test   $0x3,%al
>   3d:   75 0b                   jne    0x4a
>   3f:   5b                      pop    %rbx
>
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0:   80 3c 02 00             cmpb   $0x0,(%rdx,%rax,1)
>    4:   0f 85 ce 00 00 00       jne    0xd8
>    a:   48 8b 85 78 01 00 00    mov    0x178(%rbp),%rax
>   11:   a8 03                   test   $0x3,%al
>   13:   75 0b                   jne    0x20
>   15:   5b                      pop    %rbx
> [   76.627183][    T1] RSP: 0018:ffff888103a6f718 EFLAGS: 00010202
> [   76.628803][    T1] RAX: dffffc0000000000 RBX: ffff88810ee660f8 RCX: 0=
000000000000000
> [   76.630879][    T1] RDX: 000000000000002f RSI: ffff88816976b000 RDI: 0=
000000000000178
> [   76.632960][    T1] RBP: 0000000000000000 R08: 692d422d656e696c R09: 0=
07475706e692d42
> [   76.635045][    T1] R10: ffff888103a6f750 R11: ffffffff810b3aef R12: f=
fff88810ee66130
> [   76.641151][    T1] R13: ffff888163afb6c0 R14: 0000000000000000 R15: f=
fff888163afb6d0
> [   76.643224][    T1] FS:  0000000000000000(0000) GS:ffffffff84cd1000(00=
00) knlGS:0000000000000000
> [   76.645563][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   76.647278][    T1] CR2: 00007fab8f4456f4 CR3: 0000000004cac000 CR4: 0=
0000000000406b0
> [   76.649355][    T1] Call Trace:
> [   76.650221][    T1]  <TASK>
> [ 76.651020][ T1] ? die_addr (arch/x86/kernel/dumpstack.c:421 arch/x86/ke=
rnel/dumpstack.c:460)
> [ 76.652132][ T1] ? exc_general_protection (arch/x86/kernel/traps.c:701 a=
rch/x86/kernel/traps.c:643)
> [ 76.653604][ T1] ? asm_exc_general_protection (arch/x86/include/asm/idte=
ntry.h:564)
> [ 76.655133][ T1] ? ret_from_fork (arch/x86/kernel/process.c:153)
> [ 76.656355][ T1] ? check_init_srcu_struct (kernel/rcu/srcutree.c:408)
> [ 76.657792][ T1] synchronize_srcu (kernel/rcu/srcutree.c:1167 kernel/rcu=
/srcutree.c:1458)
> [ 76.659048][ T1] gpiod_request_commit (drivers/gpio/gpiolib.c:127 driver=
s/gpio/gpiolib.c:2273)
> [ 76.660430][ T1] gpiochip_request_own_desc (drivers/gpio/gpiolib.c:2454)
> [ 76.661898][ T1] gpiod_hog (drivers/gpio/gpiolib.c:4504)
> [ 76.663000][ T1] of_gpiochip_add_hog (drivers/gpio/gpiolib-of.c:799)
> [ 76.664334][ T1] ? __pfx_of_gpiochip_add_hog (drivers/gpio/gpiolib-of.c:=
785)
> [ 76.665830][ T1] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c=
:467 kernel/locking/lockdep.c:4360)
> [ 76.667387][ T1] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4423)
> [ 76.668763][ T1] ? _raw_spin_unlock_irqrestore (arch/x86/include/asm/pre=
empt.h:103 include/linux/spinlock_api_smp.h:152 kernel/locking/spinlock.c:1=
94)
> [ 76.670279][ T1] of_gpiochip_add (drivers/gpio/gpiolib-of.c:828 drivers/=
gpio/gpiolib-of.c:1143)
> [ 76.671550][ T1] ? fwnode_property_read_int_array (drivers/base/property=
c:268 (discriminator 5))
> [ 76.673171][ T1] gpiochip_add_data_with_key (drivers/gpio/gpiolib.c:989)
> [ 76.674714][ T1] ? kasan_save_track (arch/x86/include/asm/current.h:42 m=
m/kasan/common.c:60 mm/kasan/common.c:70)
> [ 76.676002][ T1] unittest_gpio_probe (drivers/of/unittest.c:1886)
> [ 76.677340][ T1] platform_probe (drivers/base/platform.c:1404)
> [ 76.678544][ T1] really_probe (drivers/base/dd.c:579 drivers/base/dd.c:6=
58)
> [ 76.679745][ T1] __driver_probe_device (drivers/base/dd.c:800)
> [ 76.681126][ T1] driver_probe_device (drivers/base/dd.c:830)
> [ 76.682411][ T1] __driver_attach (drivers/base/dd.c:1217)
> [ 76.683679][ T1] ? __pfx___driver_attach (drivers/base/dd.c:1157)
> [ 76.685074][ T1] bus_for_each_dev (drivers/base/bus.c:367)
> [ 76.686340][ T1] ? lockdep_init_map_type (kernel/locking/lockdep.c:4892)
> [ 76.687774][ T1] ? __pfx_bus_for_each_dev (drivers/base/bus.c:356)
> [ 76.689176][ T1] ? bus_add_driver (drivers/base/bus.c:672)
> [ 76.690452][ T1] bus_add_driver (drivers/base/bus.c:674)
> [ 76.691691][ T1] driver_register (drivers/base/driver.c:246)
> [ 76.692949][ T1] of_unittest_overlay_gpio (drivers/of/unittest.c:1969 (d=
iscriminator 4))
> [ 76.694377][ T1] of_unittest_overlay (drivers/of/unittest.c:2189 drivers=
/of/unittest.c:3217)
> [ 76.695724][ T1] ? __pfx_of_unittest_overlay (drivers/of/unittest.c:3155=
)
> [ 76.697198][ T1] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c=
:467 kernel/locking/lockdep.c:4360)
> [ 76.698764][ T1] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4423)
> [ 76.700151][ T1] of_unittest (drivers/of/unittest.c:4129)
> [ 76.701323][ T1] ? __pfx_of_unittest (drivers/of/unittest.c:4080)
> [ 76.702622][ T1] ? add_device_randomness (drivers/char/random.c:918)
> [ 76.704050][ T1] ? __pfx_of_unittest (drivers/of/unittest.c:4080)
> [ 76.705347][ T1] do_one_initcall (init/main.c:1236)
> [ 76.706572][ T1] ? __pfx_do_one_initcall (init/main.c:1227)
> [ 76.708227][ T1] do_initcalls (init/main.c:1297 init/main.c:1314)
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240212/202402122234.d85cca9b-lk=
p@intel.com
>
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

Paul,

Could you help me out here? It seems that lockdep complains (with
"suspicious RCU usage") whenever an RCU-protected pointer is passed to
rcu_dereference() but is not actually dereferenced later - in which
case switching to rcu_access_pointer() helps. But in the case of the
of_unittests() it also emits the same warning for
gpiod_direction_input() where gdev->chip is fetched with
rcu_dereference() using CLASS(gpio_chip_guard) and later actually
dereferenced by calling guard.gc->...

Any hints as to what I'm doing wrong?

Thanks,
Bartosz

