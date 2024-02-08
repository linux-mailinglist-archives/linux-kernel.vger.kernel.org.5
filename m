Return-Path: <linux-kernel+bounces-57827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2001484DDDE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 692C9B2846C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4E66E2D8;
	Thu,  8 Feb 2024 10:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DswS86sZ"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFAF6D1C6;
	Thu,  8 Feb 2024 10:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707387060; cv=none; b=mxLqWbV8HlxmRMA/NRB8VYId4KI5FglsL0Yyno3GX9aRqzgmmwIdcBrd1Wdo/5aiQ2zv5IWJuzlRN6P8LROWErEl0QDs7PXrN042gpsquTkq9DXfHm4dks5YONWxboyH8hmeBdaPsELlHgbHwlSRgi1tjHYbkvwnj4ck2XTXgoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707387060; c=relaxed/simple;
	bh=+ADWVUpmxulSouAw2nrdNM35CGaO+iwj2qTIUmABrfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7U6UKrOQq/NF2xY6fiwBfFuqW0s7Tzb+kAFBsTDl/VMT2Hrvfi3sHL8av4yDcpsXyIqC32dy15XzuZJnhztIqNbHz8nZum+8SVCt24W40XJq/evdMwrD1HjMieFlh40eH2mugOBc5jVZlZtqzbbv8S2QhAfYTmWgs2+QNwknTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DswS86sZ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3850ce741bso176849366b.3;
        Thu, 08 Feb 2024 02:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707387056; x=1707991856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t4qJqrQngjhyBVl1eFAnQz4sU3UDyhGqaXA9QuJuUdQ=;
        b=DswS86sZn991L0nBuZepU05fP9sIHZjscUsoZt/amWe6oqkVcF5dr6N7KITmjRjf2a
         woju8i/Q7WQnqAyxrOPzuyugcpDgphN8GhagCmBu3Rrw+FmQkL3+vmjfDnBT7hwQt4Lb
         eFG9OrPNBxcrnqkgDKJWfE6M0haJlAOF8KzhtEUF3VEez8APdzUcIIwzbOlrUDyN97nx
         G427XKEmZBepS1vn93EZ7MQQLsyHYjtw3tRB2xa2hx3RrKViBlhEKLFMOmFwFDKSSDDz
         I5E25aSdW0UMUtWHC0H+NF/V+puQuUQ1L/LBmMXHLPlx/LfUwce3OsDcOq+6SSspZSb+
         by4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707387056; x=1707991856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4qJqrQngjhyBVl1eFAnQz4sU3UDyhGqaXA9QuJuUdQ=;
        b=n85wq+W6bdZX/barkGPLq0nmS8I6Wq9zMUgciQMLZny03F4y15qDYFbVK5c24ZUohv
         Q9gdysuKIsmIiWISwlGOhuUo+kY1yIVMaYJvqkSggvvb9pbSiCtM1iunnMdOXT5B1z/b
         WMk0KfU+Ihlu+1ihB1vu3/7fKdwCEKXDDyK6XJVrauSvmcsOJTSe5LHKIhYEnq3ldvba
         e3uHOtTvyGLpKEyn0Rx877oea9r4RwTKR+S/nLlXWAiemEeRIyW2YcQLRVusC9/77h6l
         nFREaM0xZ24VZGm8Hul1AI7g8Us4paa1K6zdgpJerRcIJk+rJqWUYcrTIQxIr8dQAtuu
         0A+g==
X-Forwarded-Encrypted: i=1; AJvYcCXPzKtFbdKLe4TCCyiU7Z7U+eJMj+Ut/tUNwxa/pIBh0MXFcPu5nHEEXdBsEuWeSeH1YXW8DPztHzHYOjBbpzpCBLVDSgXUHkh5PmGdpfNsnTYBWcmSfHq/A+dh7zLBtjqmLYshILizdQ==
X-Gm-Message-State: AOJu0YyKQ70+d7SICRbpNKo4cwaSrY+i/2tae1PLIGIAHZfam9bd6Kf6
	m7JxBZCs8zPB90iGRdYYn5QkjMrGuIK1HMoErTZuzaoofuO2cVxH
X-Google-Smtp-Source: AGHT+IGRFIbU8FLRHZzqbsvV6g2EUVIm/++y/CMkRT3VZoUYN1lZI9EkNRHwDe4VGj0yVb98ZnoQJg==
X-Received: by 2002:a17:907:77d7:b0:a38:2ca6:5b5d with SMTP id kz23-20020a17090777d700b00a382ca65b5dmr5006644ejc.16.1707387056021;
        Thu, 08 Feb 2024 02:10:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXTmduvrzmnQ9Xj4ON9h1J3ZP5e1TxTkX3bx4vbi7MvzfB1DuOz1xJHHtEBktnaVafh+Z+gFlDgRDrB8tGlUqO7WM6LHnLFB8Uue+9LV42z/sbsSTSoGZRtxZszYGFwZM9gL1oYePpQSw0ERF6wxg26VxHCLw9z8vSnKNXGKY38k2lAo2MnPhOmbkBCFFYGonDVqI6ol9kmDt3z504p1H7AlVoJDnwP+xU7KCYJmeVoWoTDGlDOUN3qPpbFnOaOvmhWrfkG/Oqf1johsxT59+6CTS5Bh6NivFH5R9fxYCZAE57Xr+9f7Pj9QkaEkw3XgbCSExBvVJz1h3XCXGYKoSbbkBlU9xjrQ2zG/ap9J27wVPeUTjIUSHb7fkuOYBCP0LmsaZfJl+DhP+J1QlmtoCQ1AEML6un2ep3Ngwgokmc/R6PP36MWuHt/ZmpTaY6MbLs/hXDnTtuwIhFMhWipPqSHqW8a9Gzp5LguGCpROgx38MBYkU5JslvhBWfgiHuEOgxym/lSCMtbf5xdCGp2i13GBFzr4CSHplPmc69mg+xLkOAGOCmWn5CK+MOGZvVPSlDLSA5gugGBMmqXUZDoBA==
Received: from andrea ([31.189.46.254])
        by smtp.gmail.com with ESMTPSA id ss11-20020a170907c00b00b00a3868b8e78dsm1745276ejc.52.2024.02.08.02.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 02:10:55 -0800 (PST)
Date: Thu, 8 Feb 2024 11:10:50 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Saravana Kannan <saravanak@google.com>,
	Marc Zyngier <maz@kernel.org>, Anup Patel <anup@brainfault.org>,
	linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Atish Patra <atishp@atishpatra.org>,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Andrew Jones <ajones@ventanamicro.com>
Subject: Re: [PATCH v12 00/25] Linux RISC-V AIA Support
Message-ID: <ZcSoqkexSipQsrLZ@andrea>
References: <20240127161753.114685-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240127161753.114685-1-apatel@ventanamicro.com>

Hi Anup,

I understand that some refactoring is in progress, but I don't see the
report below; adding it here hoping that it can be useful towards v13.
(Unfortunately, I didn't have enough time to debug this yet...)


>   irqchip/sifive-plic: Convert PLIC driver into a platform driver

I'm seeing the following LOCKDEP warning with this series, bisected to
the commit above.  This is a defconfig + PROVE_LOCKING=y build, booted
using -machine virt,aia=none.

[    0.953473] ========================================================
[    0.953704] WARNING: possible irq lock inversion dependency detected
[    0.953955] 6.8.0-rc1-00039-gd9b9d6eb987f #1122 Not tainted
[    0.954224] --------------------------------------------------------
[    0.954444] swapper/0/0 just changed the state of lock:
[    0.954664] ffffaf808109d0c8 (&irq_desc_lock_class){-...}-{2:2}, at: handle_fasteoi_irq+0x24/0x1da
[    0.955699] but this lock took another, HARDIRQ-unsafe lock in the past:
[    0.955942]  (&handler->enable_lock){+.+.}-{2:2}
[    0.955974] 
               
               and interrupts could create inverse lock ordering between them.

[    0.956507] 
               other info that might help us debug this:
[    0.956775]  Possible interrupt unsafe locking scenario:

[    0.956998]        CPU0                    CPU1
[    0.957247]        ----                    ----
[    0.957439]   lock(&handler->enable_lock);
[    0.957607]                                local_irq_disable();
[    0.957793]                                lock(&irq_desc_lock_class);
[    0.958021]                                lock(&handler->enable_lock);
[    0.958246]   <Interrupt>
[    0.958342]     lock(&irq_desc_lock_class);
[    0.958501] 
                *** DEADLOCK ***

[    0.958715] no locks held by swapper/0/0.
[    0.958870] 
               the shortest dependencies between 2nd lock and 1st lock:
[    0.959152]  -> (&handler->enable_lock){+.+.}-{2:2} {
[    0.959372]     HARDIRQ-ON-W at:
[    0.959522]                       __lock_acquire+0x884/0x1f5c
[    0.959745]                       lock_acquire+0xf0/0x292
[    0.959913]                       _raw_spin_lock+0x2c/0x40
[    0.960090]                       plic_probe+0x322/0x65c
[    0.960257]                       platform_probe+0x4e/0x92
[    0.960432]                       really_probe+0x82/0x210
[    0.960598]                       __driver_probe_device+0x5c/0xd0
[    0.960784]                       driver_probe_device+0x2c/0xb0
[    0.960964]                       __driver_attach+0x72/0x10a
[    0.961151]                       bus_for_each_dev+0x60/0xac
[    0.961330]                       driver_attach+0x1a/0x22
[    0.961496]                       bus_add_driver+0xd4/0x19e
[    0.961666]                       driver_register+0x3e/0xd8
[    0.961835]                       __platform_driver_register+0x1c/0x24
[    0.962030]                       plic_driver_init+0x1a/0x22
[    0.962201]                       do_one_initcall+0x80/0x268
[    0.962371]                       kernel_init_freeable+0x296/0x300
[    0.962554]                       kernel_init+0x1e/0x10a
[    0.962713]                       ret_from_fork+0xe/0x1c
[    0.962884]     SOFTIRQ-ON-W at:
[    0.962994]                       __lock_acquire+0x89e/0x1f5c
[    0.963169]                       lock_acquire+0xf0/0x292
[    0.963336]                       _raw_spin_lock+0x2c/0x40
[    0.963497]                       plic_probe+0x322/0x65c
[    0.963664]                       platform_probe+0x4e/0x92
[    0.963849]                       really_probe+0x82/0x210
[    0.964054]                       __driver_probe_device+0x5c/0xd0
[    0.964255]                       driver_probe_device+0x2c/0xb0
[    0.964428]                       __driver_attach+0x72/0x10a
[    0.964603]                       bus_for_each_dev+0x60/0xac
[    0.964777]                       driver_attach+0x1a/0x22
[    0.964943]                       bus_add_driver+0xd4/0x19e
[    0.965343]                       driver_register+0x3e/0xd8
[    0.965527]                       __platform_driver_register+0x1c/0x24
[    0.965732]                       plic_driver_init+0x1a/0x22
[    0.965908]                       do_one_initcall+0x80/0x268
[    0.966078]                       kernel_init_freeable+0x296/0x300
[    0.966268]                       kernel_init+0x1e/0x10a
[    0.966436]                       ret_from_fork+0xe/0x1c
[    0.966599]     INITIAL USE at:
[    0.966716]                      __lock_acquire+0x3fc/0x1f5c
[    0.966891]                      lock_acquire+0xf0/0x292
[    0.967048]                      _raw_spin_lock+0x2c/0x40
[    0.967206]                      plic_probe+0x322/0x65c
[    0.967360]                      platform_probe+0x4e/0x92
[    0.967522]                      really_probe+0x82/0x210
[    0.967678]                      __driver_probe_device+0x5c/0xd0
[    0.967853]                      driver_probe_device+0x2c/0xb0
[    0.968025]                      __driver_attach+0x72/0x10a
[    0.968185]                      bus_for_each_dev+0x60/0xac
[    0.968348]                      driver_attach+0x1a/0x22
[    0.968513]                      bus_add_driver+0xd4/0x19e
[    0.968678]                      driver_register+0x3e/0xd8
[    0.968839]                      __platform_driver_register+0x1c/0x24
[    0.969035]                      plic_driver_init+0x1a/0x22
[    0.969239]                      do_one_initcall+0x80/0x268
[    0.969431]                      kernel_init_freeable+0x296/0x300
[    0.969610]                      kernel_init+0x1e/0x10a
[    0.969766]                      ret_from_fork+0xe/0x1c
[    0.969936]   }
[    0.970010]   ... key      at: [<ffffffff824f4138>] __key.2+0x0/0x10
[    0.970224]   ... acquired at:
[    0.970353]    lock_acquire+0xf0/0x292
[    0.970482]    _raw_spin_lock+0x2c/0x40
[    0.970609]    plic_irq_enable+0x7e/0x140
[    0.970739]    irq_enable+0x2c/0x60
[    0.970882]    __irq_startup+0x58/0x60
[    0.971008]    irq_startup+0x5e/0x13c
[    0.971126]    __setup_irq+0x4de/0x5da
[    0.971248]    request_threaded_irq+0xcc/0x12e
[    0.971394]    vm_find_vqs+0x62/0x50a
[    0.971518]    probe_common+0xfe/0x1d2
[    0.971635]    virtrng_probe+0xc/0x14
[    0.971751]    virtio_dev_probe+0x154/0x1fc
[    0.971878]    really_probe+0x82/0x210
[    0.972008]    __driver_probe_device+0x5c/0xd0
[    0.972147]    driver_probe_device+0x2c/0xb0
[    0.972280]    __driver_attach+0x72/0x10a
[    0.972407]    bus_for_each_dev+0x60/0xac
[    0.972540]    driver_attach+0x1a/0x22
[    0.972656]    bus_add_driver+0xd4/0x19e
[    0.972777]    driver_register+0x3e/0xd8
[    0.972896]    register_virtio_driver+0x1c/0x2a
[    0.973049]    virtio_rng_driver_init+0x18/0x20
[    0.973236]    do_one_initcall+0x80/0x268
[    0.973399]    kernel_init_freeable+0x296/0x300
[    0.973540]    kernel_init+0x1e/0x10a
[    0.973658]    ret_from_fork+0xe/0x1c

[    0.973858] -> (&irq_desc_lock_class){-...}-{2:2} {
[    0.974036]    IN-HARDIRQ-W at:
[    0.974142]                     __lock_acquire+0xa82/0x1f5c
[    0.974309]                     lock_acquire+0xf0/0x292
[    0.974467]                     _raw_spin_lock+0x2c/0x40
[    0.974625]                     handle_fasteoi_irq+0x24/0x1da
[    0.974794]                     generic_handle_domain_irq+0x1c/0x2a
[    0.974982]                     plic_handle_irq+0x7e/0xf0
[    0.975143]                     generic_handle_domain_irq+0x1c/0x2a
[    0.975329]                     riscv_intc_irq+0x2e/0x46
[    0.975488]                     handle_riscv_irq+0x4a/0x74
[    0.975652]                     call_on_irq_stack+0x32/0x40
[    0.975817]    INITIAL USE at:
[    0.975923]                    __lock_acquire+0x3fc/0x1f5c
[    0.976087]                    lock_acquire+0xf0/0x292
[    0.976244]                    _raw_spin_lock_irqsave+0x3a/0x64
[    0.976423]                    __irq_get_desc_lock+0x5a/0x84
[    0.976594]                    irq_modify_status+0x2a/0x106
[    0.976764]                    irq_set_percpu_devid+0x62/0x78
[    0.976939]                    riscv_intc_domain_map+0x1e/0x54
[    0.977133]                    irq_domain_associate_locked+0x42/0xe4
[    0.977363]                    irq_create_mapping_affinity+0x98/0xd4
[    0.977570]                    sbi_ipi_init+0x70/0x142
[    0.977744]                    init_IRQ+0xfe/0x11a
[    0.977906]                    start_kernel+0x4ae/0x790
[    0.978082]  }
[    0.978151]  ... key      at: [<ffffffff824bbee0>] irq_desc_lock_class+0x0/0x10
[    0.978389]  ... acquired at:
[    0.978494]    mark_lock+0x3fe/0x8c2
[    0.978624]    __lock_acquire+0xa82/0x1f5c
[    0.978766]    lock_acquire+0xf0/0x292
[    0.978897]    _raw_spin_lock+0x2c/0x40
[    0.979029]    handle_fasteoi_irq+0x24/0x1da
[    0.979171]    generic_handle_domain_irq+0x1c/0x2a
[    0.979326]    plic_handle_irq+0x7e/0xf0
[    0.979460]    generic_handle_domain_irq+0x1c/0x2a
[    0.979618]    riscv_intc_irq+0x2e/0x46
[    0.979751]    handle_riscv_irq+0x4a/0x74
[    0.979888]    call_on_irq_stack+0x32/0x40

[    0.980110] 
               stack backtrace:
[    0.980358] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.8.0-rc1-00039-gd9b9d6eb987f #1122
[    0.980662] Hardware name: riscv-virtio,qemu (DT)
[    0.980913] Call Trace:
[    0.981042] [<ffffffff80007198>] dump_backtrace+0x1c/0x24
[    0.981246] [<ffffffff80ae020a>] show_stack+0x2c/0x38
[    0.981456] [<ffffffff80aedac4>] dump_stack_lvl+0x5a/0x7c
[    0.981648] [<ffffffff80aedafa>] dump_stack+0x14/0x1c
[    0.981813] [<ffffffff80ae17a4>] print_irq_inversion_bug.part.0+0x162/0x176
[    0.982031] [<ffffffff8007c6e6>] mark_lock+0x3fe/0x8c2
[    0.982198] [<ffffffff8007d888>] __lock_acquire+0xa82/0x1f5c
[    0.982377] [<ffffffff8007f59e>] lock_acquire+0xf0/0x292
[    0.982549] [<ffffffff80af9962>] _raw_spin_lock+0x2c/0x40
[    0.982721] [<ffffffff8008f3fe>] handle_fasteoi_irq+0x24/0x1da
[    0.982904] [<ffffffff8008a4a4>] generic_handle_domain_irq+0x1c/0x2a
[    0.983112] [<ffffffff80581dc0>] plic_handle_irq+0x7e/0xf0
[    0.983293] [<ffffffff8008a4a4>] generic_handle_domain_irq+0x1c/0x2a
[    0.983495] [<ffffffff8057fb1a>] riscv_intc_irq+0x2e/0x46
[    0.983671] [<ffffffff80aedb4c>] handle_riscv_irq+0x4a/0x74
[    0.983856] [<ffffffff80afa756>] call_on_irq_stack+0x32/0x40


When I switch to -machine virt,aia=aplic-imsic (same config as above), I
get:

[    0.971406] ============================================
[    0.971439] WARNING: possible recursive locking detected
[    0.971497] 6.8.0-rc1-00039-gd9b9d6eb987f #1122 Not tainted
[    0.971583] --------------------------------------------
[    0.971612] swapper/0/1 is trying to acquire lock:
[    0.971662] ffffaf83fefa8e78 (&lpriv->ids_lock){-...}-{2:2}, at: imsic_vector_move+0x92/0x146
[    0.971927] 
               but task is already holding lock:
[    0.971975] ffffaf83fef6ee78 (&lpriv->ids_lock){-...}-{2:2}, at: imsic_vector_move+0x86/0x146
[    0.972045] 
               other info that might help us debug this:
[    0.972085]  Possible unsafe locking scenario:

[    0.972114]        CPU0
[    0.972133]        ----
[    0.972153]   lock(&lpriv->ids_lock);
[    0.972191]   lock(&lpriv->ids_lock);
[    0.972228] 
                *** DEADLOCK ***

[    0.972258]  May be due to missing lock nesting notation

[    0.972306] 6 locks held by swapper/0/1:
[    0.972338]  #0: ffffaf8081f65970 (&dev->mutex){....}-{3:3}, at: __driver_attach+0x6a/0x10a
[    0.972413]  #1: ffffaf808217c240 (&desc->request_mutex){+.+.}-{3:3}, at: __setup_irq+0xa2/0x5da
[    0.972492]  #2: ffffaf808217c0c8 (&irq_desc_lock_class){....}-{2:2}, at: __setup_irq+0xbe/0x5da
[    0.972555]  #3: ffffffff81892ac0 (mask_lock){....}-{2:2}, at: irq_setup_affinity+0x38/0xc6
[    0.972617]  #4: ffffffff81892a80 (tmp_mask_lock){....}-{2:2}, at: irq_do_set_affinity+0x3a/0x164
[    0.972681]  #5: ffffaf83fef6ee78 (&lpriv->ids_lock){-...}-{2:2}, at: imsic_vector_move+0x86/0x146
[    0.972753] 
               stack backtrace:
[    0.972852] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 6.8.0-rc1-00039-gd9b9d6eb987f #1122
[    0.972900] Hardware name: riscv-virtio,qemu (DT)
[    0.972987] Call Trace:
[    0.973019] [<ffffffff80007198>] dump_backtrace+0x1c/0x24
[    0.973054] [<ffffffff80ae020a>] show_stack+0x2c/0x38
[    0.973083] [<ffffffff80aedac4>] dump_stack_lvl+0x5a/0x7c
[    0.973112] [<ffffffff80aedafa>] dump_stack+0x14/0x1c
[    0.973139] [<ffffffff8007ad5e>] print_deadlock_bug+0x282/0x328
[    0.973168] [<ffffffff8007e15c>] __lock_acquire+0x1356/0x1f5c
[    0.973198] [<ffffffff8007f59e>] lock_acquire+0xf0/0x292
[    0.973225] [<ffffffff80af9adc>] _raw_spin_lock_irqsave+0x3a/0x64
[    0.973255] [<ffffffff80581210>] imsic_vector_move+0x92/0x146
[    0.973285] [<ffffffff80581a04>] imsic_irq_set_affinity+0x8e/0xc6
[    0.973315] [<ffffffff8008c86a>] irq_do_set_affinity+0x142/0x164
[    0.973345] [<ffffffff8008cc22>] irq_setup_affinity+0x68/0xc6
[    0.973374] [<ffffffff8008fa82>] irq_startup+0x72/0x13c
[    0.973401] [<ffffffff8008d40c>] __setup_irq+0x4de/0x5da
[    0.973430] [<ffffffff8008d5d4>] request_threaded_irq+0xcc/0x12e
[    0.973460] [<ffffffff806346d8>] vp_find_vqs_msix+0x114/0x376
[    0.973491] [<ffffffff80634970>] vp_find_vqs+0x36/0x136
[    0.973518] [<ffffffff80633280>] vp_modern_find_vqs+0x16/0x4e
[    0.973547] [<ffffffff80ab31f8>] p9_virtio_probe+0x8e/0x31c
[    0.973576] [<ffffffff8062d982>] virtio_dev_probe+0x154/0x1fc
[    0.973605] [<ffffffff80693738>] really_probe+0x82/0x210
[    0.973632] [<ffffffff80693922>] __driver_probe_device+0x5c/0xd0
[    0.973661] [<ffffffff806939c2>] driver_probe_device+0x2c/0xb0
[    0.973690] [<ffffffff80693b46>] __driver_attach+0x72/0x10a
[    0.973718] [<ffffffff8069191a>] bus_for_each_dev+0x60/0xac
[    0.973746] [<ffffffff80693164>] driver_attach+0x1a/0x22
[    0.973773] [<ffffffff80692ade>] bus_add_driver+0xd4/0x19e
[    0.973801] [<ffffffff8069487e>] driver_register+0x3e/0xd8
[    0.973829] [<ffffffff8062d1ce>] register_virtio_driver+0x1c/0x2a
[    0.973858] [<ffffffff80c3da52>] p9_virtio_init+0x36/0x56
[    0.973887] [<ffffffff800028fe>] do_one_initcall+0x80/0x268
[    0.973915] [<ffffffff80c01144>] kernel_init_freeable+0x296/0x300
[    0.973944] [<ffffffff80af05dc>] kernel_init+0x1e/0x10a
[    0.973972] [<ffffffff80afa716>] ret_from_fork+0xe/0x1c


FWIW, the full Qemu command I used was as follows:

	sudo /home/andrea/Downloads/qemu/build/qemu-system-riscv64 \
		-append "root=/dev/root rw rootfstype=9p rootflags=version=9p2000.L,trans=virtio,cache=mmap,access=any raid=noautodetect security=none loglevel=7" \
		-cpu rv64,sv57=off,svadu=off,svnapot=off \
		-device virtio-net-device,netdev=net0 \
		-device virtio-rng-device,rng=rng0 \
		-device virtio-9p-pci,fsdev=root,mount_tag=/dev/root \
		-fsdev local,id=root,path=/home/andrea/Downloads/jammy/,security_model=none \
		-kernel /home/andrea/linux/arch/riscv/boot/Image \
		-m 16G \
		-machine virt,aia=<either "none" or "aplic-imsic"> \
		-monitor telnet:127.0.0.1:55555,server,nowait \
		-netdev user,id=net0,host=10.0.2.10,hostfwd=tcp::10022-:22 \
		-nographic \
		-object rng-random,filename=/dev/urandom,id=rng0 \
		-serial mon:stdio \
		-smp 5


  Andrea

