Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0847F08B9
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 21:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjKST7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 14:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKST7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 14:59:01 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABE8C6;
        Sun, 19 Nov 2023 11:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=toYGyXAw4pSqVPIpTOL+xkcBrZVHFF2mcg2JdO/5Qxs=;
        t=1700423938; x=1701633538; b=ePJ23XIOvat7Qq1zDAAR8miy7amhaw+6xx2ohjbg6bzpd6S
        +z8HsRV+yTXnOnmJ6+pFndwGs0Nt2aBVKPVufuzD9N5mD78B/wGkWJZr0/CIoT+SSipP/r53qovYC
        6UFht/1FukMPW+mMvmOzzbEM7ZHS7RtRNREBRMd+O1heXM4y8AWqg9F9hMNSTp7754GY+QTJ3pO7Q
        h8Aewqw6+ymrsWwA7ZkyozMzBcDrec9eeu95N+s/6tJGAaRcgnC3YIPyMv0NEzPZDhQKmAYns6O5x
        n9gK6ZDhUAcqbPnx4fGO9iW6DzuKTrgT3Gfc21MXRsAtNXjyJ1hfA1KCehLEt+cw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97)
        (envelope-from <johannes@sipsolutions.net>)
        id 1r4nw2-0000000E81r-2EPI;
        Sun, 19 Nov 2023 20:58:26 +0100
Message-ID: <098e2983ac299cb3b33bd0a8e33aaab8d6235909.camel@sipsolutions.net>
Subject: Re: [PATCH 12/34] wifi: intel: use atomic find_bit() API where
 appropriate
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
        Stanislaw Gruszka <stf_xl@wp.pl>,
        Kalle Valo <kvalo@kernel.org>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        linux-wireless@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>
Date:   Sun, 19 Nov 2023 20:58:25 +0100
In-Reply-To: <20231118155105.25678-13-yury.norov@gmail.com>
References: <20231118155105.25678-1-yury.norov@gmail.com>
         <20231118155105.25678-13-yury.norov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-11-18 at 07:50 -0800, Yury Norov wrote:
> iwlegacy and iwlwifi code opencodes atomic bit allocation/traversing by
> using loops.=20

That's really just due to being lazy though, it could use a non-atomic
__test_and_set_bit() would be just fine in all of this, there's always a
mutex held around it that protects the data.

Not that it means that the helper is _wrong_, it's just unnecessary, and
you don't have non-atomic versions of these, do you?

johannes

