Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC477DFABA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 20:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbjKBTOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 15:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjKBTO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 15:14:29 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B561C188;
        Thu,  2 Nov 2023 12:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1698952460;
        bh=O7wEcDJtrGJ2yEwB0sEkgTD3GrHwoBv5RI3h12B/TWg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mPDbYyzj2o7kfdQXXedsrUe8Ts0XLpOU4a2ChB6jMnNoFOwzBU97iZ5d7QZ00ekr4
         BirHopLx8Qy05TCzR71Ua/aGkDs4JdExXFm45Bsz8W5tT/23QYJSV2X/Br3bfo9uKn
         7bmJ/7HLYGg+8BnqSk72TpcADtK5s4dA533fXfgA=
Date:   Thu, 2 Nov 2023 20:14:19 +0100
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rfkill: return ENOTTY on invalid ioctl
Message-ID: <613039a4-41af-48ff-8113-3b0ee8077bcf@t-8ch.de>
References: <20231101-rfkill-ioctl-enosys-v1-1-5bf374fabffe@weissschuh.net>
 <a069393c-86b3-ef79-82dd-0b60caf2a907@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a069393c-86b3-ef79-82dd-0b60caf2a907@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 2023-11-02 09:57:45+0100, Przemek Kitszel wrote:
> On 11/1/23 20:41, Thomas Weißschuh wrote:
> > For unknown ioctls the correct error is
> > ENOTTY "Inappropriate ioctl for device".
> 
> For sure!
> 
> I would like to learn more of why this is not an UAPI breaking change?

"break" would mean that some user application worked correctly before
but does not do so anymore with this change.

This seems highly unlikely and I was not able to find such an
application via Debian code search.

In general I did *not* mark this change for stable so if some
application would indeed break it gets detected before the patch hits
a release.

> > 
> > ENOSYS as returned before should only be used to indicate that a syscall
> > is not available at all.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> >   net/rfkill/core.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/rfkill/core.c b/net/rfkill/core.c
> > index 14cc8fe8584b..c3feb4f49d09 100644
> > --- a/net/rfkill/core.c
> > +++ b/net/rfkill/core.c
> > @@ -1351,11 +1351,11 @@ static long rfkill_fop_ioctl(struct file *file, unsigned int cmd,
> >   			     unsigned long arg)
> >   {
> >   	struct rfkill_data *data = file->private_data;
> > -	int ret = -ENOSYS;
> > +	int ret = -ENOTTY;
> >   	u32 size;
> >   	if (_IOC_TYPE(cmd) != RFKILL_IOC_MAGIC)
> > -		return -ENOSYS;
> > +		return -ENOTTY;
> >   	mutex_lock(&data->mtx);
> >   	switch (_IOC_NR(cmd)) {
> > 
> > ---
> > base-commit: 7d461b291e65938f15f56fe58da2303b07578a76
> > change-id: 20231101-rfkill-ioctl-enosys-00a2bb0a4ab1
> > 
> > Best regards,
> 
