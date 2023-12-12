Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3E880F430
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbjLLROs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:14:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234944AbjLLROq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:14:46 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE12E9F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 09:14:52 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1d343f8e139so3269205ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 09:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702401292; x=1703006092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OOmVxyvlV9iC91AJreDAWLoQkSzQ2NPxXA9m17q8MxY=;
        b=b7pAbrzr6VIlhGCfNZIuie1yBO3ZO+FRSRO7bH+PQ7EeJtVsKvROlTzTOwOyBaK6Qy
         +fM9XuSO6IXyzjYCfBVbcB17qj3gik6SCKWiEzSaOfQg1PILl1l2P0ysM0dyO/l6lO02
         9UoG9wdCtZZKsrc3+2TBOWANmpuMQ+6RXsLni5xbkmq5dZQcwjRmuNMIF9wOMp8SaCfg
         l21mzp6VXcBsci8DKewH/XY0WEJ3mqS8RuGSnkCKt6546ZoAgAy8GUiJtUtpATxvNcZQ
         x/EU2sYUdgCiMX2U5su61Voc7rkX6B0Zhj1caiCO62OUcXYHz3LDdoIcRpapYadTiErN
         ubnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702401292; x=1703006092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OOmVxyvlV9iC91AJreDAWLoQkSzQ2NPxXA9m17q8MxY=;
        b=gjE8u3rzK6LB72pkX8Rhx6oACZXEKURTXSvWOD1uA7T/wkZOS+lDIfXwFmWowoVsGY
         peQEZt04gEONimQ+QAIl/pvBiud4PyIGxg6U0iWdQSqn/9Il3vDwjOfIYUAzEIKmw3aa
         E8ctezPmBdnWRzZZ4TBGFOgP/Yu1Pw0kKEBL5Lb2JNwrzxnjQ3VsyRvO+DXwWEVKbbDd
         X71JyN5waJGXsHcwvZ4nNDi+edXlG73VMxh+Stu3Q4Vsbr5LzTGR+rbX1IAQNgIdSAo8
         Z4xWT4f3Ghh7tGT/SEmirwb8MdY1ETWifm3ybhAOBZfrqPStlgn1RXW3VezZHSilsfER
         ZvXw==
X-Gm-Message-State: AOJu0Yx0FxMi+HdWuszpNZoLKKX1dxtBy1pTTG/OB2aMZavzPcYGQIAI
        U+eCEQr2lTiuMICInhKQgwE=
X-Google-Smtp-Source: AGHT+IGj1R0cYd/c1GD99AOTF4Uco9bwWxEs4SagyXZt3mu96Srr1MFzMlXgV0/GDKsu1I56Q7xFyw==
X-Received: by 2002:a17:902:bc4c:b0:1d0:91a0:a29 with SMTP id t12-20020a170902bc4c00b001d091a00a29mr3127951plz.6.1702401292134;
        Tue, 12 Dec 2023 09:14:52 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id z14-20020a170903018e00b001cfc15993efsm8896620plg.163.2023.12.12.09.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 09:14:50 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 12 Dec 2023 07:14:48 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Aaron Tomlin <atomlin@atomlin.com>, linux-kernel@vger.kernel.org,
        jiangshanlai@gmail.com, peterz@infradead.org
Subject: Re: [RFC PATCH 0/2] workqueue: Introduce PF_WQ_RESCUE_WORKER
Message-ID: <ZXiVCOKk90Fjpmhw@slm.duckdns.org>
References: <20230729135334.566138-1-atomlin@atomlin.com>
 <um77hym4t6zyypfbhwbaeqxpfdzc657oa7vgowdfah7cuctjak@pexots3mfb24>
 <ZXdXdBzvbkI4Y4fL@slm.duckdns.org>
 <ZXguMgcKLCLn16T4@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXguMgcKLCLn16T4@localhost.localdomain>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Juri.

On Tue, Dec 12, 2023 at 10:56:02AM +0100, Juri Lelli wrote:
> Hummm, OK, but in terms of which CPU the rescuer is possibly woken up,
> how are we making sure that the wake up is always happening on
> housekeeping CPUs (assuming unbound workqueues have been restricted to
> those)?
> 
> AFAICS, we have
> 
> send_mayday ->
>   wake_up_process(wq->rescuer->task)
> 
> which is not affined to the workqueue cpumask it's called to rescue, so
> in theory can be woken up anywhere?

Ah, was only thinking about work item execution. Yeah, it's not following
the isolation rule there and we probably should affine it as we're waking it
up.

Thanks.

-- 
tejun
