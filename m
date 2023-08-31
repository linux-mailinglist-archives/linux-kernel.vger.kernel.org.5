Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D1878F5BF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 00:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241696AbjHaWnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 18:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbjHaWni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 18:43:38 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC862CC
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 15:43:35 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4RcGRB3KsDz5s;
        Fri,  1 Sep 2023 00:43:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1693521814; bh=EweCD2J3flQ/hUUS9jLoV+AsXy7NZcrw8OsFoGGPHCE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ALYqpVe9ZIFgz1V2ssP+vo49B8m69INRRp6NRDPD+Gue5orn2pGx6JWLYDQrfEhKK
         ePEBKdQnBAb5UdbNJdJlkd6bawayTfPpVeIcpeAtff3WtvBfxihc1w5Mgy1MuE69PD
         5aXvTyyUHJPdISS28HZXkAiBb9LTD103hS/SXnsH1Nm7IFjjuKCQ1q5vyOUObXusLl
         EDSq5feLleFM2jgtHZHJgSfQiG/g8h9rFUPktM79tUh3lUrHZJNTCaflmBQ0RzVwAE
         h8wlOn0pn6BmJq1TSibc5kC790+RLbl66aukD57E+6FevZZ3CTliUjSXOWQixdaYX0
         6NMSNnxuxnyow==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.8 at mail
Date:   Fri, 1 Sep 2023 00:43:33 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] regulator/core: regulator_lock_nested: simplify
 nested locking
Message-ID: <ZPEXlf26YBQB4WMt@qmqm.qmqm.pl>
References: <cover.1693416477.git.mirq-linux@rere.qmqm.pl>
 <56ae0bf828d942c92ca867afb3aae95fcabd5498.1693416477.git.mirq-linux@rere.qmqm.pl>
 <CAE-0n53a75cgRNJOdn1=19OG_yJt9DDXHZ4quhZwCtZiQ1RUxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE-0n53a75cgRNJOdn1=19OG_yJt9DDXHZ4quhZwCtZiQ1RUxQ@mail.gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 01:36:38PM -0700, Stephen Boyd wrote:
> Quoting Micha³ Miros³aw (2023-08-30 10:35:31)
> > Simplify regulator locking by removing locking around locking.
> 
> Maybe this should say "Simplify regulator_lock_nested() by removing the
> `regulator_nesting_mutex` now that rdev is locked whenever rdev->ref_cnt or
> rdev->owner are modified"?

I'll rework the message. Thanks for the hints!

[...]
> > Note: return -EALREADY is removed as no caller depends on it and in that
> > case the lock count is incremented anyway.
> 
> Where is -EALREADY removed in this patch? Perhaps "removed" should be
> "ignored"?
> 
> Note: A return value of -EALREADY from ww_mutex_lock() in
> regulator_lock_nested() is ignored as no caller depends on it.

I can actually remove this altogether: ww_mutex_lock() won't ever
return -EALREADY as it's called only if (rdev->mutex_owner != current).

Best Regards.
Micha³ Miros³aw
