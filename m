Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F17E7B4225
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 18:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbjI3QbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 12:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234506AbjI3QbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 12:31:21 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FE5DD
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 09:31:17 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4063bfc6c03so46145e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 09:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696091476; x=1696696276; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oVAYMt1psfEMubw8IExYSnqOjs4RqYc6AhVubaDiWyY=;
        b=VkBa0lGSahf/nivE9g7CLynqfuZdR0kC0Eo8hK2ck9QpK4i2QMUdpulFWwG+OytqV8
         ik7IBvpsfFeqJZmKlzel1jejTagAF8k+v0OhlzW5WB6SKwgjR7tddkuA6879iw5h/fRh
         ZkQalWPCNe7MMYlSxBtB3Rh4T21zu5fa8iNGJVIJ1YaTQW/JWlB0RXn4shqpukTSzR91
         lgKXTmU83yQdmLno4oOs7Hri1ElqfmX6s1r/UmIw10na4NZVQlTONJPLaKrtr1JUvSdE
         gBq95EJuvVkkM/GG/ylR0fUZx0uguKSmIvpNzJkrXmgTFSZEupoDwk7uEvq6cY2OdaKW
         nCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696091476; x=1696696276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVAYMt1psfEMubw8IExYSnqOjs4RqYc6AhVubaDiWyY=;
        b=hk49qdo88C+5/jc4UiazyjQnOdHxdiKApWDJVe54OqDYdIaQsZpdEwYpUnHTW/FtrP
         89kUXuOuu4LxRLV2zOlO4wel3XrC0V2G68tIoNBv0de4uDHiCd+iIePDKeQgw3fUMEbV
         BH6ES18oNCuZoDo64OFrC4wV9soUsx87rUCdo50E1u/ZIDufiJ1gq/ZYqgsuR2mD34lF
         +mIXaJaan8NmncxcR2vCGOX4naCbsxOIUrMfbx8XAoXW2XdMwZDJ8BaztnVsnlujYpWa
         bBg2zz6u5ZN0dt8YgSiG3bO1V4yrxdE+Kv+bGzZpCt/quVVhreCom9o6JO0O0tXVEZ/F
         +KiQ==
X-Gm-Message-State: AOJu0Yzc3aQ5kdGcioZ+FzE3jYNj3UZTthednd6lR34x7bDFMl1EIk6g
        CXX8GI2YTU/0hOmj2UaN+J6VcQ==
X-Google-Smtp-Source: AGHT+IE05FnJ40TW4VSxbBtmPDLXWFsJ3SYtZrcILDXuw81e+XeYk1uYw8caO8kdD27BC5EnLy/hww==
X-Received: by 2002:a05:600c:3b87:b0:3f7:3e85:36a with SMTP id n7-20020a05600c3b8700b003f73e85036amr20307wms.7.1696091475846;
        Sat, 30 Sep 2023 09:31:15 -0700 (PDT)
Received: from google.com (110.121.148.146.bc.googleusercontent.com. [146.148.121.110])
        by smtp.gmail.com with ESMTPSA id t25-20020a7bc3d9000000b00405391f485fsm3703154wmj.41.2023.09.30.09.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 09:31:15 -0700 (PDT)
Date:   Sat, 30 Sep 2023 16:31:13 +0000
From:   Sebastian Ene <sebastianene@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        will@kernel.org, ryan.roberts@arm.com, mark.rutland@arm.com,
        vdonnefort@google.com
Subject: Re: [PATCH 00/11] arm64: ptdump: View the host stage-2 page-tables
Message-ID: <ZRhNUUSdoA62eydt@google.com>
References: <20230927112517.2631674-1-sebastianene@google.com>
 <87a5t5m8ec.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5t5m8ec.wl-maz@kernel.org>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 02:11:23PM +0100, Marc Zyngier wrote:

Hello Marc,

Thanks for having a look.

> Hi Sebastian,
> 
> On Wed, 27 Sep 2023 12:25:06 +0100,
> Sebastian Ene <sebastianene@google.com> wrote:
> > 
> > Hi,
> > 
> > This can be used as a debugging tool for dumping the host stage-2
> > page-tables under pKVM envinronment.
> 
> Why only pKVM? Why only the host? Dumping page tables shouldn't be
> reserved to this corner case. Specially considering that pKVM is still
> really far away from being remotely useful upstream.
>

I wanted to publish the initial series which adds support for the host
and then extend it to guest VMs. 

> I'd really expect this sort of debugging information to be fully
> available for both host and guest, for all modes (nVHE, VHE, hVHE,
> protected, nested), without limitations other than the configuration
> option.

I agree, let me re-spin the series and add support for non-protected as
well.

> 
> Also, please Cc the relevant parties (I'm the only one Cc'd on the KVM
> side...)
>

Thanks,

Sebastian

> Thanks,
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.
