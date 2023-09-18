Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF617A5220
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 20:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjIRSgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 14:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjIRSgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 14:36:14 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDC910D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 11:36:09 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c39f2b4f5aso34734685ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 11:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695062168; x=1695666968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xmoP4D8SNsHwxgtDQChBM6WNBNz1czN6sdkoECkKUiI=;
        b=a23OvHOlY1CbCmRQUz2zm/4NjLZSP65y/OrsA72CooeWvBs5wgqMr6shbmONUUJ5y5
         hV4J7MXb8RKYL8CraodVO61LOM0v0As7A7MgpaTg7mVJ9spUxZcfRXB3ykI68eLaT8K5
         10MvbIcstmkslO5fqlBXzBrMYTOlXk3vfoyg2jgZlf4UCP2po26vkDR6eZzRcISBMiaH
         psYb+kBQEHteIvonECyIDdQXnYAJ2tNMiRSKzu2xYcQ8hcR1Z4zB2iiFen9FZdErgDlz
         c0D+WJuZLNTgNzpSG3oBpgw7WFSTv4TqUsG9RhGDapjMlAAR0YJHSRM6uVSrYqPp0tXw
         /nHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695062168; x=1695666968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xmoP4D8SNsHwxgtDQChBM6WNBNz1czN6sdkoECkKUiI=;
        b=nW6vx0xGefSfxe18ZMpluSvhdLT51jrRSNN2W8hejozsnAeOQQ5CvAPgSTXhSVg+tH
         /Z6SLo8Eb5tu1GG/HQcmkeZUk+BHFGk5h5mpxh74fXKMM2Y42ffKq785mZjlhdR3e5lj
         bDTf7ksnkEN5iYbWeE5uTsiN5VOJDO8c9XX+k/vFUCrlebxa7KrIxcHGupHyUvLYbZoo
         2R0emre/T8glF7+qg1xEFSZ+U6cw3d7Q5UTNiuaWqCIx4WkwDMEZmwbU8xqyVmtK2jEF
         pd7alY6Ukhqkeix0CD30vNPBhcAOq8erCrkxgabEGQIDdV/B/RFR4ta+CyeKlKKnU9Tw
         Oznw==
X-Gm-Message-State: AOJu0YwCdfGD3K9iNhi14ZxfjHDI/vSVLrnttWoRLh5PxKKicg4Gh1Z8
        qRbNc1QmDyjIFWybjXCYDNstYC5tfUT5uA==
X-Google-Smtp-Source: AGHT+IElBzEq7CIomw9VF3eBQ2y141NFjkatFccj4tFgXU6NtUcarBUVgVGA8s4gcrJF7T+r0z56MA==
X-Received: by 2002:a17:903:1c8:b0:1c3:9544:cf63 with SMTP id e8-20020a17090301c800b001c39544cf63mr11178824plh.23.1695062168606;
        Mon, 18 Sep 2023 11:36:08 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id jn3-20020a170903050300b001c0ce518e98sm8573241plb.224.2023.09.18.11.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 11:36:08 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 18 Sep 2023 08:36:06 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] workqueue: Removed double allocation of
 wq_update_pod_attrs_buf
Message-ID: <ZQiYljXyWou_bzWp@slm.duckdns.org>
References: <20230905174935.2d75feab@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905174935.2d75feab@gandalf.local.home>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 05:49:35PM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> First commit 2930155b2e272 ("workqueue: Initialize unbound CPU pods later in
> the boot") added the initialization of wq_update_pod_attrs_buf to
> workqueue_init_early(), and then latter on, commit 84193c07105c6
> ("workqueue: Generalize unbound CPU pods") added it as well. This appeared
> in a kmemleak run where the second allocation made the first allocation
> leak.
> 
> Fixes: 84193c07105c6 ("workqueue: Generalize unbound CPU pods")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Applied to wq/for-6.6-fixes.

Thanks.

-- 
tejun
