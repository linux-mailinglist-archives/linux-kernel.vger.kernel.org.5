Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CED176C12C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 01:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjHAXmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 19:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjHAXmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 19:42:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE7E268E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 16:42:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F14861779
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 23:42:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCDCDC433C8;
        Tue,  1 Aug 2023 23:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690933347;
        bh=z0fmdgzeuoBofNmQQG5TKdCgYOx55EJdXWUBZ5kbeUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MyPQmhGyJhqdhOy1gTnoZUeiHQGBf/BZ6Lhs/RNyDwzX0pqQnwxFZavOb3fuBRGGD
         JA23Je9StEtBOlW5+W9EsEEzAiU1pLNLgNzDZrFLQ9zCRjU9rXVVosbM6bOD0FEaV2
         ZGkg3OjuR9wVf4Uu+XNxFlUMwihPt7ELBGnUIjgaix9wGe8OfRrhYXDBavKrZNk6L3
         1JkM3pt0CgaWootK5miPPEEAWmgTnZ4jBkUYCoQsy4qhrfH6+D/bpqEPiLjvp8UwZs
         4N/BS58hWGt62As9/khpNr967iCcPG2B6+VZGAXFLRFxveR4LOWxDq/HM1S4HbxKDL
         viGmJoawal45g==
Date:   Wed, 2 Aug 2023 01:42:24 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Feng Liu <feliu@nvidia.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Wolfram Sang <wsa@kernel.org>
Subject: Re: [PATCH] virtio: Remove PM #ifdef guards to fix i2c driver
Message-ID: <20230801234224.e33sikkjug276ktt@intel.intel>
References: <20230801105846.3708252-1-arnd@kernel.org>
 <c809220b8f10c6c9a3d05bbbd416fbb27d654d2d.camel@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c809220b8f10c6c9a3d05bbbd416fbb27d654d2d.camel@crapouillou.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 02, 2023 at 01:06:47AM +0200, Paul Cercueil wrote:
> Hi,
> 
> Le mardi 01 août 2023 à 12:58 +0200, Arnd Bergmann a écrit :
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > A cleanup in the virtio i2c caused a build failure:
> > 
> > drivers/i2c/busses/i2c-virtio.c:270:10: error: 'struct virtio_driver'
> > has no member named 'freeze'
> > drivers/i2c/busses/i2c-virtio.c:271:10: error: 'struct virtio_driver'
> > has no member named 'restore'
> > 
> > Change the structure definition to allow this cleanup to
> > be applied everywhere.
> > 
> > Fixes: 73d546c76235b ("i2c: virtio: Remove #ifdef guards for PM
> > related functions")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Thanks, I didn't realize it was merged already.
> 
> Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Actually this fix is taken from linux-next, it's not in
Wolfram's branch, it's in mine. I can still force-push a fixed
version in Paul's original patch in order to avoid breaking the
bisectability.

Andi
