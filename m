Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FE778BB31
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 00:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbjH1Wvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 18:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbjH1WvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 18:51:09 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3B313E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 15:51:06 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-53482b44007so1681550a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 15:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693263066; x=1693867866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T4nyTONQLjQNGWZ4CdwYM7KX6zvJ5hhuHchlfrQVnFg=;
        b=U/jGmUT4ZMYOwz1wyVXxKZzwd5Z7io9GqpQrDOrUqXUDPkOP69ywj9jTtekn/lPlKF
         +jI7KSDKs01z02xFMIaNQDOvk5Id0q5I/ftVNN9Pam8s85ySBUKRx5riBy+U9MXhbsC0
         WQl9Xc5fR7pgKuFqfaXTF8dec/+/LknMu9jbFswg8KZ80ZoydNjjssClQiClaGamRMbF
         RdTCfgvGzPbD0FGFv+8hQABCf0cN2lQY5j9zDwEzU2tsbIseHmaomEG6ujOP4bzA/UHF
         jbMWpV67UbmA2V5YyOGk0EMZEpfSOmOBFHj3ScjqfvZPeRep86fy2nszVjhHN5UKATfT
         OVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693263066; x=1693867866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T4nyTONQLjQNGWZ4CdwYM7KX6zvJ5hhuHchlfrQVnFg=;
        b=fBLAQsIuSrS2v7KEdVEouI7hyHCrZ4shrMUbQ+c2rj1jAuRoko6/YMV147zJSD75ZE
         60jCbrxlFyIDPSciUlUdziQ+GSLD0OetMs57h2Tku/5AEGfHMXI/fWkCLMnq3LeP4fBW
         uCx7Xm0MqSEujM4eoEThmdpVm92ZbQyVCfB8shJKSVSwNpRqPy6E5BtIYKVZwxxDgwoB
         w4eT1J23q15bmEnVqCmk18/sgjdrt5sfZgFXBYpAj/u8Vj13WtQ5wscUunhWAFnY9fpC
         phbgXwj4Zd2lT3gVVR1zqbbNrLhvzNjzVmRAOfnFfSRXqfHQZcVv7usxMPiylI7G4x0w
         3iHA==
X-Gm-Message-State: AOJu0YxbXZluuYcwWginJO/taqUxKXqUmAPLc8+oDe8zYMKU43Nk8Ur3
        ElureO3y2NsyC/hzo0HthLXCmQ==
X-Google-Smtp-Source: AGHT+IFhgZce2iRj25QUKt5ra95exWE6EmZCshSfmAByuDSFGHPibt9BU7lzSXl6OJECuiWZ8kwf1Q==
X-Received: by 2002:a17:90a:b10f:b0:271:ab23:6288 with SMTP id z15-20020a17090ab10f00b00271ab236288mr871992pjq.14.1693263065657;
        Mon, 28 Aug 2023 15:51:05 -0700 (PDT)
Received: from google.com ([2620:15c:2d1:203:b64:7817:9989:9eba])
        by smtp.gmail.com with ESMTPSA id j15-20020a17090a2a8f00b00262ca945cecsm10108812pjd.54.2023.08.28.15.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 15:51:05 -0700 (PDT)
Date:   Mon, 28 Aug 2023 15:51:00 -0700
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Heiko Carstens' <hca@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan =?iso-8859-1?Q?H=F6ppner?= <hoeppner@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        llvm@lists.linux.dev
Subject: Re: [PATCH 1/1] s390/dasd: fix string length handling
Message-ID: <ZO0k1Par4i4FBCWF@google.com>
References: <20230828153142.2843753-1-hca@linux.ibm.com>
 <20230828153142.2843753-2-hca@linux.ibm.com>
 <f0419f6428ad404386ebca813dc1ec03@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0419f6428ad404386ebca813dc1ec03@AcuMS.aculab.com>
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

On Mon, Aug 28, 2023 at 05:18:37PM +0000, David Laight wrote:
> From: Heiko Carstens
> > Sent: 28 August 2023 16:32
> >  	if (strlen(uid.vduit) > 0)
> 
> Does the compiler know enough to optimise that brain-dead test?
> 

For the purposes of skipping diagnostics, no; clang performs semantic
analysis BEFORE optimization (which is handled by LLVM). As such, clang
will produce diagnostics on dead code.

Partly because LLVM isn't very ergonomic at emitting diagnostics from
the backend, partly because Clang code owner and developers don't want
clang to emit diagnostics dependent on optimization level.

I disagree with my compatriots, and you can read more thoughts here:
https://discourse.llvm.org/t/rfc-improving-clangs-middle-and-back-end-diagnostics/69261?u=nickdesaulniers
