Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B96A7AB975
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 20:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbjIVSmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 14:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbjIVSmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 14:42:45 -0400
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815DAA9;
        Fri, 22 Sep 2023 11:42:39 -0700 (PDT)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1c3cbfa40d6so22975025ad.1;
        Fri, 22 Sep 2023 11:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695408159; x=1696012959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uy4Qx3oAlemzZ68pG10cO3ool7kPh2NALLfQXvvFL/M=;
        b=H2pbrAMvmp8v/KmbukUu/IxvsRmZB1t7TwZCQVN0Sc8XFsyqE7dt6JE1po/DS2Ht5A
         AOKOflk+ncq6YqNGDxLBxE+HMcyBJFrTqRTVBErAGZFVG3GEkRH+b9MKT+U0jgQ31jGJ
         Uwbi7f6INYV7AuRzCSifMjtZCZsETV4rbKAj6yVRpvcSt9VuhqiCtHSLuj3kjktOW2/d
         OB7nHh+1pFnn5AzyKa+I8UPrjMU2h55G8/4eCS5VVzZ6R5w1mv9Mjdagol/nas0ZLrlM
         v4HJRvOnF0t/gM+HarXQrUy9qIC3WTGgGl1L1/KZXvE8zLkJKTCcF2k5zlqtw0YQ/59B
         ndBg==
X-Gm-Message-State: AOJu0YyEGHIzEJ6N8s+UFqelRvTEURXeVp3GZm1mseFkHCpHEo6zySPG
        nvgbiNivJA6csWnifL4NBnfEHjyCOME=
X-Google-Smtp-Source: AGHT+IE8Zjcqr0VIt3JGl7z6pVgiqpImUuwwkhyrlyBkP+oL46ew3ySJ0QlB4eTQ9I7Qsih5vWVmCg==
X-Received: by 2002:a17:903:120a:b0:1c4:2641:7744 with SMTP id l10-20020a170903120a00b001c426417744mr332698plh.25.1695408158778;
        Fri, 22 Sep 2023 11:42:38 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id l20-20020a170903005400b001bc18e579aesm3831240pla.101.2023.09.22.11.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 11:42:38 -0700 (PDT)
Date:   Fri, 22 Sep 2023 18:41:55 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        vkuznets@redhat.com, ssengar@microsoft.com
Subject: Re: [PATCH v3] x86/hyperv: Restrict get_vtl to only VTL platforms
Message-ID: <ZQ3f8wY0R8OqEmIl@liuwe-devbox-debian-v2>
References: <1695182675-13405-1-git-send-email-ssengar@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1695182675-13405-1-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 09:04:35PM -0700, Saurabh Sengar wrote:
> When Linux runs in a non-default VTL (CONFIG_HYPERV_VTL_MODE=y),
> get_vtl() must never fail as its return value is used in negotiations
> with the host. In the more generic case, (CONFIG_HYPERV_VTL_MODE=n) the
> VTL is always zero so there's no need to do the hypercall.
> 
> Make get_vtl() BUG() in case of failure and put the implementation under
> "if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)" to avoid the call altogether in
> the most generic use case.
> 
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Applied to hyperv-fixes. Thanks.
