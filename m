Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F427C7777
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442582AbjJLT4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442549AbjJLTz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:55:59 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734A7BB;
        Thu, 12 Oct 2023 12:55:57 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-694ed847889so1172793b3a.2;
        Thu, 12 Oct 2023 12:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697140557; x=1697745357; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HaXzfbWU3i0lFXzPNJ6yDNrmxF0PjC7ivMbZMx14cp8=;
        b=gqg7Z+DzQ9F/PGlBVjxOnuTlSfMe1LJsH6/vIqOF+ID18kAdB3301WA6V85EEjSs+Z
         MzFAf188TB0aPO7ERbdvIkcJ8WUKnhBof2jNZRhb5/CFQipdVf4vyq7PtSfS8R6m5FSk
         BLKxxLeuN5okQcyApR9vFmw/aZI2iTRoXxowVgcOm+da4H6lWJ4QOB4nFFOozjhXJCN0
         PJ2StuOx2lTLW0GggcVfIjrybUjjggG8+ZnRFEZ2j5AWjHt89oTU2Yq67+kGc5IpADYC
         5Es7hio1+qlosaECtSMzweOAm8cOzyBIQnoSXV1ytIfZ55Xl26a0Z9dgE36Egf5el3wo
         qN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697140557; x=1697745357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HaXzfbWU3i0lFXzPNJ6yDNrmxF0PjC7ivMbZMx14cp8=;
        b=H0zVBlaRC7a+4T8yu11eMuGpIAnNX+6CdhgdjwTD3Hsnulj2MXayYbO9fweLqnbKhQ
         8F18PipxBBLwbqCqIdyHIVVIFYmbT1ovAKqIZO1Pqjgjn3gGyWzVLsyGzke093/y0B0Y
         C882zLMLveS7elelbjJh8vw7kUwUBRVv+YazbPHDZZAGmzTmZj9gzHnn67vU/KbG3FN7
         vRq4G8A4ZwG7G3D3qeuanDqklqzqpkFxNPQtGfC0Hf03Upypy9DhD8pCearuCAexEieW
         9fCt7cKW1+zSChte4r0T+SLm45u7Sk8S/+vXSJm3rm1z4iv/zuOrl2YIbmIUI7Kbsq+7
         +Zug==
X-Gm-Message-State: AOJu0Yw12d/mKV+2iqUxpH9p0GD20njKjr3Ni7x6v+WET2D8Br6orWFw
        8dIRgD3Dme9GRex92QoPql0=
X-Google-Smtp-Source: AGHT+IFIF+ce4T/COXsxWRK2KNuzL4fVcLJw8q/kp9HKKm+JujcfAT3D1IwTuETLD41GqcEjk+SoLQ==
X-Received: by 2002:a05:6a20:6a28:b0:15e:5e8c:e45c with SMTP id p40-20020a056a206a2800b0015e5e8ce45cmr25423385pzk.30.1697140556879;
        Thu, 12 Oct 2023 12:55:56 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id z125-20020a633383000000b0058a381de499sm2075450pgz.77.2023.10.12.12.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 12:55:56 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 12 Oct 2023 09:55:55 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Andrew Theurer <atheurer@redhat.com>,
        Joe Mario <jmario@redhat.com>,
        Sebastian Jug <sejug@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH] blk-mq: add module parameter to not run block kworker on
 isolated CPUs
Message-ID: <ZShPS46jgVsaBGHY@slm.duckdns.org>
References: <20231010142216.1114752-1-ming.lei@redhat.com>
 <ZSWb2DNV9cIPYv5H@slm.duckdns.org>
 <ZSXuqZNsyjJk1FGX@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSXuqZNsyjJk1FGX@fedora>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Oct 11, 2023 at 08:39:05AM +0800, Ming Lei wrote:
> I appreciate that any specific suggestions about dealing with isolated CPUs
> generically for bound WQ can be shared.

Oh, all I meant was whether we can at least collect this into or at least
adjacent to the existing housekeeping / isolcpu parameters. Let's say
there's someone who really wants to isolated some CPUs, how would they find
out the different parameters if they're scattered across different
subsystems?

Thanks.

-- 
tejun
