Return-Path: <linux-kernel+bounces-36542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 005E683A2D7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25A801C21A11
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F53168B1;
	Wed, 24 Jan 2024 07:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKiqW/cI"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780AA15AD0;
	Wed, 24 Jan 2024 07:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706081092; cv=none; b=NAf1QoN03viI2+KNxjgldTJyhCc2bRG4Dl8TtP2sXAIzDuo9lZg2W8nkdbxM38PYYCOB453kJKr0epB3vyCt44j1ew6CrWPRGMuBlly3ObzEAEYpbYzNQLKu4c9cVLYTwnT4xUUgD7Klbm5HZZtrVdlPGnZ0zVfIzEwoNcGti9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706081092; c=relaxed/simple;
	bh=WWcer+kqlrBjmyHjO8nVJpN9FjCZ90bTxdh1Y+qumqw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F88fxr0Lo0lXICmvucYWgC2wOHW4w9Pt0qOeGRJnFHkoU5FLbl2j5R3li63GgQ513OF5UHfJUDJvPvcA5GonYeGfy0Xa2vX12ECcGDMh1EWEW/NfCneUsClqh+zh7VCaXJVqRxpq8xdfqpbtFZzIgeFcVVYBYvBRqZb6aiLxJAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKiqW/cI; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5100ed2b33dso801369e87.0;
        Tue, 23 Jan 2024 23:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706081088; x=1706685888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=54W4OuXjo14UqfedG3c4VPXK+UL+VMD/8Mdf376TSqU=;
        b=FKiqW/cIFWd5ywaZ3FVmEIpqAI/bGTy0BrzLKga/Ir6HU+a6BfqatPobaLYoU84Iun
         zBN2aymBgBuvTYvMXOepe+cj9AFU7TxGds2rJtScgI2RgLtQY1xrekp5K+2IwsZggk12
         mF0DYIFMdX6j5RtbRaCwesl1c7qAi6h8TF2hIM+9vbs3MmRJIcOBY99BO5QdudwL7lUc
         MZzy08YzJ63QaSw4JZQR6WqXYYEZQFyHs6DYgf8qSEt9nK0Wx2jnuAPmCjCcN1WB4PBG
         gqbqMSpsPTMMW35cdiP56IlnST24YyvE6jzlnS6MlJSgB4xkqee7tzIqokQsIuarP64t
         8qrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706081088; x=1706685888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=54W4OuXjo14UqfedG3c4VPXK+UL+VMD/8Mdf376TSqU=;
        b=rLGGPGl7neDLyiHM+9Juub72n36WNFRks2A1gw3BjpjqHZGkisNnuMGyiHMnuUdmdI
         KObuJ4SP1cEdstqSEwPAiFZheljqp1tjVqc2FUNStRxEcMXytwtFy3VH/x19/m7Lbuof
         Nb5E7Mte8QLnjIBELPJj2o8R18fHtm4oevZDel0K585oK6kiOdnvRKYBpHQzoWWQ6KxT
         d3U3oIIg1r8gxYn//WTMQhjUUFVZ69x4+59pxdOx4xg3UV6THkeSdQu/MHB0M03USrj8
         S4Fl68ZdEU2Z8JdI20U6A60HEyHgyVQDasH8j0ZZ66NaJ7vYWmfmVyuFnCZqpESxROI3
         CmhQ==
X-Gm-Message-State: AOJu0YzA5iWoHAVpyHAVhHAGfdc46bkbvQ0IHMNWmSimW9rxoyBLo+Bj
	4Aux1WhqJ3N4ZvZKpKWvf/Mm8GSBFvb8WoMXTQbKCg/ldLFql5dY9rpPIvEl
X-Google-Smtp-Source: AGHT+IHTfE2goIfBHZ68udQ1ciU6FVyuhqOmN5nUmX6sQlg1y3BOKcXiVbzBhsr2WeopVT66DlEYcw==
X-Received: by 2002:a05:6512:a90:b0:50e:a9da:7b2b with SMTP id m16-20020a0565120a9000b0050ea9da7b2bmr4041835lfu.94.1706081088081;
        Tue, 23 Jan 2024 23:24:48 -0800 (PST)
Received: from user-PC.. ([178.134.198.138])
        by smtp.gmail.com with ESMTPSA id c18-20020a056512105200b0050e64a0c62dsm2481708lfb.240.2024.01.23.23.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 23:24:47 -0800 (PST)
From: Maksim Kiselev <bigunclemax@gmail.com>
To: 
Cc: Justin Sanders <justin@coraid.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maksim Kiselev <bigunclemax@gmail.com>
Subject: [PATCH v1 0/1] aoe: possible interrupt unsafe locking scenario
Date: Wed, 24 Jan 2024 10:24:35 +0300
Message-Id: <20240124072436.3745720-1-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

I'm using an AoE device on board with D1 SoC (riscv arch).
When I enabled CONFIG_PROVE_LOCKING option, I got the warning below.
After some investigations, I made a not very elegant, but working solution.
The patch sent with next message.

I would be glad to know what you think about this.

[ 3039.629033] aoe: 0050b6b92f30 e1.1 v4019 has 264192 sectors                                            
[ 3039.637315]                                                                                            
[ 3039.638831] =====================================================                                      
[ 3039.644921] WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected                                
[ 3039.651534] 6.7.0-next-20240119-00003-gc826d21919ac-dirty #7 Not tainted                               
[ 3039.658233] -----------------------------------------------------                                      
[ 3039.664322] kworker/0:0/8 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:                                
[ 3039.670940] ffffffd803082a60 (&bdev->bd_size_lock){+.+.}-{2:2}, at: bdev_set_nr_sectors+0x20/0x44      
[ 3039.679854]                                                                                            
[ 3039.679854] and this task is already holding:                                                          
[ 3039.685684] ffffffd803b44238 (&d->lock){..-.}-{2:2}, at: aoeblk_gdalloc+0xe8/0x322                     
[ 3039.693298] which would create a new lock dependency:                                                  
[ 3039.698349]  (&d->lock){..-.}-{2:2} -> (&bdev->bd_size_lock){+.+.}-{2:2}                               
[ 3039.705089]                                                                                            
[ 3039.705089] but this new dependency connects a SOFTIRQ-irq-safe lock:                                  
[ 3039.713002]  (&d->lock){..-.}-{2:2}                                                                    
[ 3039.713023]                                                                                            
[ 3039.713023] ... which became SOFTIRQ-irq-safe at:                                                      
[ 3039.722682]   __lock_acquire+0x730/0x170c                                                              
[ 3039.726704]   lock_acquire+0xb2/0x21a                                                                  
[ 3039.730375]   _raw_spin_lock_irqsave+0x3a/0x64                                                         
[ 3039.734833]   aoecmd_cfg_rsp+0xc6/0x43a                                                                
[ 3039.738683]   aoenet_rcv+0x19a/0x1c2                                                                   
[ 3039.742267]   __netif_receive_skb_list_core+0x13c/0x146                                                
[ 3039.747510]   netif_receive_skb_list_internal+0x19e/0x2ae                                              
[ 3039.752920]   napi_complete_done+0x4a/0x16a                                                            
[ 3039.757115]   r8152_poll+0x20c/0x79c                                                                   
[ 3039.760700]   __napi_poll.constprop.0+0x26/0x19a                                                       
[ 3039.765328]   net_rx_action+0x10e/0x226                                                                
[ 3039.769175]   __do_softirq+0x180/0x3a4                                                                 
[ 3039.772937]   irq_exit_rcu+0x7e/0xa6                                                                   
[ 3039.776524]   handle_riscv_irq+0x40/0x4e                                                               
[ 3039.780466]   call_on_irq_stack+0x1c/0x28                                                              
[ 3039.784486]                                                                                            
[ 3039.784486] to a SOFTIRQ-irq-unsafe lock:                                                              
[ 3039.789970]  (&bdev->bd_size_lock){+.+.}-{2:2}                                                         
[ 3039.789992]                                                                                            
[ 3039.789992] ... which became SOFTIRQ-irq-unsafe at:                                                    
[ 3039.800777] ...                                                                                        
[ 3039.800783]   __lock_acquire+0x3a2/0x170c                                                              
[ 3039.806548]   lock_acquire+0xb2/0x21a                                                                  
[ 3039.810221]   _raw_spin_lock+0x2c/0x40                                                                 
[ 3039.813980]   bdev_set_nr_sectors+0x20/0x44                                                            
[ 3039.818173]   set_capacity+0xe/0x16                                                                    
[ 3039.821680]   zram_add+0xdc/0x1fa                                                                      
[ 3039.825006]   zram_init+0xf8/0x124                                                                     
[ 3039.828422]   do_one_initcall+0x4e/0x1ca                                                               
[ 3039.832356]   kernel_init_freeable+0x1be/0x218                                                         
[ 3039.836812]   kernel_init+0x1e/0x10a                                                                   
[ 3039.840405]   ret_from_fork+0xe/0x1c                                                                   
[ 3039.843991]                                                                                            
[ 3039.843991] other info that might help us debug this:                                                  
[ 3039.843991]                                                                                            
[ 3039.851990]  Possible interrupt unsafe locking scenario:                                               
[ 3039.851990]                                                                                            
[ 3039.858773]        CPU0                    CPU1                                                        
[ 3039.863302]        ----                    ----                                                        
[ 3039.867829]   lock(&bdev->bd_size_lock);                                                               
[ 3039.871762]                                local_irq_disable();                                        
[ 3039.877678]                                lock(&d->lock);                                             
[ 3039.883172]                                lock(&bdev->bd_size_lock);                                  
[ 3039.889619]   <Interrupt>                                                                              
[ 3039.892241]     lock(&d->lock);                                                                        
[ 3039.895393]                                                                                            
[ 3039.895393]  *** DEADLOCK ***                                                                          
[ 3039.895393]                                                                                            
[ 3039.901309] 3 locks held by kworker/0:0/8:                                                             
[ 3039.905409]  #0: ffffffd802a95530 ((wq_completion)aoe_wq){+.+.}-{0:0}, at: process_one_work+0x110/0x3ce
[ 3039.914849]  #1: ffffffc800043db8 ((work_completion)(&d->work)){+.+.}-{0:0}, at: process_one_work+0x110
/0x3ce                                                                                                    
[ 3039.924799]  #2: ffffffd803b44238 (&d->lock){..-.}-{2:2}, at: aoeblk_gdalloc+0xe8/0x322                
[ 3039.932848]                                                                                            
[ 3039.932848] the dependencies between SOFTIRQ-irq-safe lock and the holding lock:                       
[ 3039.941715] -> (&d->lock){..-.}-{2:2} {                                                                
[ 3039.945576]    IN-SOFTIRQ-W at:                                                                        
[ 3039.948724]                     __lock_acquire+0x730/0x170c                                            
[ 3039.954307]                     lock_acquire+0xb2/0x21a                                                
[ 3039.959538]                     _raw_spin_lock_irqsave+0x3a/0x64                                       
[ 3039.965554]                     aoecmd_cfg_rsp+0xc6/0x43a                                              
[ 3039.970966]                     aoenet_rcv+0x19a/0x1c2                                                 
[ 3039.976112]                     __netif_receive_skb_list_core+0x13c/0x146                              
[ 3039.982915]                     netif_receive_skb_list_internal+0x19e/0x2ae                            
[ 3039.989885]                     napi_complete_done+0x4a/0x16a                                          
[ 3039.995641]                     r8152_poll+0x20c/0x79c                                                 
[ 3040.000788]                     __napi_poll.constprop.0+0x26/0x19a                                     
[ 3040.006977]                     net_rx_action+0x10e/0x226                                              
[ 3040.012384]                     __do_softirq+0x180/0x3a4                                               
[ 3040.017706]                     irq_exit_rcu+0x7e/0xa6                                                 
[ 3040.022854]                     handle_riscv_irq+0x40/0x4e                                             
[ 3040.028355]                     call_on_irq_stack+0x1c/0x28                                            
[ 3040.033937]    INITIAL USE at:                                                                         
[ 3040.036999]                    __lock_acquire+0x3ae/0x170c                                             
[ 3040.042492]                    lock_acquire+0xb2/0x21a                                                 
[ 3040.047638]                    _raw_spin_lock_irqsave+0x3a/0x64                                        
[ 3040.053565]                    aoecmd_cfg_rsp+0xc6/0x43a                                               
[ 3040.058893]                    aoenet_rcv+0x19a/0x1c2                                                  
[ 3040.063951]                    __netif_receive_skb_list_core+0x13c/0x146                               
[ 3040.070663]                    netif_receive_skb_list_internal+0x19e/0x2ae                             
[ 3040.077547]                    napi_complete_done+0x4a/0x16a                                           
[ 3040.083215]                    r8152_poll+0x20c/0x79c                                                  
[ 3040.088273]                    __napi_poll.constprop.0+0x26/0x19a                                      
[ 3040.094376]                    net_rx_action+0x10e/0x226                                               
[ 3040.099696]                    __do_softirq+0x180/0x3a4                                                
[ 3040.104931]                    irq_exit_rcu+0x7e/0xa6                                                  
[ 3040.109992]                    handle_riscv_irq+0x40/0x4e                                              
[ 3040.115402]                    call_on_irq_stack+0x1c/0x28                                             
[ 3040.120896]  }                                                                                         
[ 3040.122565]  ... key      at: [<ffffffff822deea8>] __key.2+0x0/0x10                                    
[ 3040.128848]                                                                                            
[ 3040.128848] the dependencies between the lock to be acquired                                           
[ 3040.128856]  and SOFTIRQ-irq-unsafe lock:                                                              
[ 3040.139994] -> (&bdev->bd_size_lock){+.+.}-{2:2} {                                                     
[ 3040.144811]    HARDIRQ-ON-W at:                                                                        
[ 3040.147960]                     __lock_acquire+0x390/0x170c                                            
[ 3040.153542]                     lock_acquire+0xb2/0x21a                                                
[ 3040.158774]                     _raw_spin_lock+0x2c/0x40                                               
[ 3040.164093]                     bdev_set_nr_sectors+0x20/0x44                                          
[ 3040.169848]                     set_capacity+0xe/0x16                                                  
[ 3040.174912]                     zram_add+0xdc/0x1fa                                                    
[ 3040.179798]                     zram_init+0xf8/0x124                                                   
[ 3040.184775]                     do_one_initcall+0x4e/0x1ca                                             
[ 3040.190269]                     kernel_init_freeable+0x1be/0x218                                       
[ 3040.196288]                     kernel_init+0x1e/0x10a                                                 
[ 3040.201439]                     ret_from_fork+0xe/0x1c                                                 
[ 3040.206587]    SOFTIRQ-ON-W at:                                                                        
[ 3040.209735]                     __lock_acquire+0x3a2/0x170c                                            
[ 3040.215316]                     lock_acquire+0xb2/0x21a                                                
[ 3040.220546]                     _raw_spin_lock+0x2c/0x40                                               
[ 3040.225866]                     bdev_set_nr_sectors+0x20/0x44                                          
[ 3040.231618]                     set_capacity+0xe/0x16                                                  
[ 3040.236678]                     zram_add+0xdc/0x1fa                                                    
[ 3040.241563]                     zram_init+0xf8/0x124                                                   
[ 3040.246536]                     do_one_initcall+0x4e/0x1ca                                             
[ 3040.252028]                     kernel_init_freeable+0x1be/0x218                                       
[ 3040.258044]                     kernel_init+0x1e/0x10a                                                 
[ 3040.263193]                     ret_from_fork+0xe/0x1c                                                 
[ 3040.268341]    INITIAL USE at:                                                                         
[ 3040.271402]                    __lock_acquire+0x3ae/0x170c                                             
[ 3040.276896]                    lock_acquire+0xb2/0x21a                                                 
[ 3040.282041]                    _raw_spin_lock+0x2c/0x40                                                
[ 3040.287273]                    bdev_set_nr_sectors+0x20/0x44                                           
[ 3040.292939]                    set_capacity+0xe/0x16                                                   
[ 3040.297913]                    zram_add+0xdc/0x1fa                                                     
[ 3040.302712]                    zram_init+0xf8/0x124                                                    
[ 3040.307600]                    do_one_initcall+0x4e/0x1ca                                              
[ 3040.313005]                    kernel_init_freeable+0x1be/0x218                                        
[ 3040.318936]                    kernel_init+0x1e/0x10a                                                  
[ 3040.323998]                    ret_from_fork+0xe/0x1c                                                  
[ 3040.329059]  }                                                                                         
[ 3040.330728]  ... key      at: [<ffffffff822d4d18>] __key.5+0x0/0x10                                    
[ 3040.337010]  ... acquired at:                                                                          
[ 3040.339980]    check_prev_add+0xf8/0xb40                                                               
[ 3040.343913]    __lock_acquire+0xd0e/0x170c                                                             
[ 3040.348017]    lock_acquire+0xb2/0x21a                                                                 
[ 3040.351775]    _raw_spin_lock+0x2c/0x40                                                                
[ 3040.355620]    bdev_set_nr_sectors+0x20/0x44                                                           
[ 3040.359899]    set_capacity+0xe/0x16                                                                   
[ 3040.363486]    +0x180/0x322                                                              
[ 3040.367514]    aoecmd_sleepwork+0x2e/0x7c                                                              
[ 3040.371536]    process_one_work+0x176/0x3ce                                                            
[ 3040.375740]    worker_thread+0x19a/0x348                                                               
[ 3040.379674]    kthread+0xd0/0xec                                                                       
[ 3040.382918]    ret_from_fork+0xe/0x1c                                                                  
[ 3040.386596]                                                                                            
[ 3040.388091]                                                                                            
[ 3040.388091] stack backtrace:                                                                           
[ 3040.392449] CPU: 0 PID: 8 Comm: kworker/0:0 Not tainted 6.7.0-next-20240119-00003-gc826d21919ac-dirty #7
[ 3040.401929] Hardware name: Sipeed Lichee RV Dock (DT)                                                  
[ 3040.406983] Workqueue: aoe_wq aoecmd_sleepwork                                                         
[ 3040.411450] Call Trace:                                                                                
[ 3040.413901] [<ffffffff800067b2>] dump_backtrace+0x1c/0x24                                              
[ 3040.419316] [<ffffffff809d176a>] show_stack+0x2c/0x38                                                  
[ 3040.424382] [<ffffffff809de7c2>] dump_stack_lvl+0x2e/0x48                                              
[ 3040.429798] [<ffffffff809de7f0>] dump_stack+0x14/0x1c                                                  
[ 3040.434862] [<ffffffff800511fc>] check_irq_usage+0x786/0x798                                           
[ 3040.440531] [<ffffffff80051306>] check_prev_add+0xf8/0xb40                                             
[ 3040.446026] [<ffffffff80053b22>] __lock_acquire+0xd0e/0x170c                                           
[ 3040.451693] [<ffffffff80054cc4>] lock_acquire+0xb2/0x21a                                               
[ 3040.457013] [<ffffffff809e91be>] _raw_spin_lock+0x2c/0x40                                              
[ 3040.462424] [<ffffffff8032468c>] bdev_set_nr_sectors+0x20/0x44                                         
[ 3040.468268] [<ffffffff8033ff0c>] set_capacity+0xe/0x16                                                 
[ 3040.473422] [<ffffffff805d32e2>] aoeblk_gdalloc+0x180/0x322                                            
[ 3040.479013] [<ffffffff805d5208>] aoecmd_sleepwork+0x2e/0x7c                                            
[ 3040.484599] [<ffffffff8002b612>] process_one_work+0x176/0x3ce                                          
[ 3040.490361] [<ffffffff8002ba04>] worker_thread+0x19a/0x348                                             
[ 3040.495857] [<ffffffff80033d08>] kthread+0xd0/0xec                                                     
[ 3040.500661] [<ffffffff809e9ebe>] ret_from_fork+0xe/0x1c                                                
[ 3040.538247]  etherd/e1.1: p1

Maksim Kiselev (1):
  aoe: avoid potential deadlock at set_capacity

 drivers/block/aoe/aoeblk.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
2.40.1


