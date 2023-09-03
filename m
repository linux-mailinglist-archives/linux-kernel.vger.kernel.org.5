Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091BF790C22
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 15:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238026AbjICNhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 09:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238000AbjICNhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 09:37:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38E8FB
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 06:37:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48A1860917
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 13:37:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D73C433C9;
        Sun,  3 Sep 2023 13:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693748253;
        bh=SGeYKy0hSTsfUbH5Oruf0ELnxmWXsRUwXsp08daMSLE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O21ulBxawbKOIi19AmK5EPk0R1l3RMr1SqVcJvZJ/u8qgzg6MQmcbvG5fgepZqS6F
         u6ab1xGxAava6kBCyjffrugavx/sL1go1IHpuMZ2/9VpWZ6uR/pJk4zWJo6LJcTXmo
         009a3J7wCEkknfEbbdZRBBc7X57ByyI7UirpnYkc=
Date:   Sun, 3 Sep 2023 14:54:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Edward AD <eadavis@sina.com>
Cc:     syzbot+85792f3143e6271d2c97@syzkaller.appspotmail.com,
        andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] kobject: fix kobj and fmt are both null
Message-ID: <2023090328-slam-verbose-957d@gregkh>
References: <0000000000007b589e0604578e70@google.com>
 <20230903124231.3748101-1-eadavis@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230903124231.3748101-1-eadavis@sina.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 03, 2023 at 08:42:31PM +0800, Edward AD wrote:
> If kobj and fmt are both NULL, it will cause an exception in kvasprintf_const,
> then when this situation occurs, -EINVAL is directly returned.

How can this happen?  Are there any in-kernel users that cause this to
occur?

If so, which ones, why not fix that?

And your description isn't quite correct here, you are not checking for
kobj, but rather kobj->name.

thanks,

greg k-h
