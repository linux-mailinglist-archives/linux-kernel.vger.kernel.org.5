Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14C27DC8D4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 09:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235344AbjJaI75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 04:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235753AbjJaI7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 04:59:54 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5460BE8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 01:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=HolwFtH31Q6ywKQODQ0148en20rqb3PsUXQ91SE+TOY=;
        t=1698742791; x=1699952391; b=Sy27MN8iVjWwE3XGdhMdVktv6Rd1BKZsMsroEsXTIQ7zFVo
        9RttbYY5Ml2veAieJk3UP1SaqTfXPx0gnE+2/MaigyMzIrWlpu2PbSxEzDu5R/u3qvRuuO2LR8KuA
        n5pNjOCXCcU7p1Agfw7B6IWTEdPsAcxmmQbVk4BDyVTdtbC2LkwXN9NRiOFV8UHsV2xNnPSvSxu7M
        yZb7ZA4iNXkYlEo7tmdknWdf7EiMQDAOhsKxBJmr0Iv99OLVfpZY7NGLiCEXveLNaqDhxJijJWlBe
        C8fzSbQCemrUSFCMmGlkPshaDaRVCyeRbwvclWaEboVM5jZSIYqANJHePRxU/N4g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97-RC1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qxkbE-000000091HJ-0OuS;
        Tue, 31 Oct 2023 09:59:48 +0100
Message-ID: <d00e8976baa4fb93a1f3f1191998994540bb173b.camel@sipsolutions.net>
Subject: Re: [PATCH] Devcoredump: fix use-after-free issue when releasing
 devcd device
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Yu Wang <quic_yyuwang@quicinc.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org, kernel@quicinc.com
Date:   Tue, 31 Oct 2023 09:59:47 +0100
In-Reply-To: <ab509035-cf3c-4902-87a8-cbba03ac948c@quicinc.com>
References: <20231027055521.2679-1-quic_yyuwang@quicinc.com>
         <2023102730-twins-thieving-d04e@gregkh>
         <22ab53d1ae36d4925732e6e1dc989dc75af126da.camel@sipsolutions.net>
         <ab509035-cf3c-4902-87a8-cbba03ac948c@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-10-31 at 16:29 +0800, Yu Wang wrote:
>=20
> In this case, the device is temporarily added for dump only, so we need t=
o
> delete it when dump is completed.
> The other users doesn't add/delete the device like this.

For good reason, I guess? I think this is probably a bad idea.

The whole point of this was to actually know which device created the
coredump? If you make one up on the fly that's ... pointless? Surely you
must have _some_ device that already exists?

> It removes the device when the @free function has been called, I think
> the @free function should be considered as a completion signal, and so
> we need to put @free at the end of falling-device-related-clean-up in
> devcoredump framework (the change in the patch).

That may be true for the case you have, but really, I wouldn't consider
that a bug now?

Besides, we do hav<e put_device() at the end, and I'm not sure I see how
the device can be removed before put_device()?

Can parts of the device there disappear before we release all the
references? Could that mean the scenario is also possible without your
contorted device creation and removal, just by unplugging the device
while a coredump exists in sysfs?

> Yes, I know we don't need to care about the dump data, but as mentioned
> upon, the device is locally and temporarily created for this one-time dum=
p
> only, we need to free it when dump is completed, so introduce this comple=
tion.
> Refer to drivers/remoteproc/remoteproc_coredump.c.

I still don't think this is right ... Even the code there is awful, it
potentially blocks for 5 minutes? I'm not sure we should encourage that.

Note that you could also argue exactly the other way around - what if
the *free* function requires access to the device? It gets arbitrary
data after all.


> Regarding NULL for the struct module pointer, looks it's allowed for this
> API (<remoteproc_coredump.c> also pass NULL)? But yes, it's not nice inde=
ed,
> we need this to get a reference of the calling module for safety.
> Will correct in the next patch set.

Well, it's not really allowed to literally write NULL - maybe we should
have a macro that fills in THIS_MODULE. But THIS_MODULE can be NULL at
runtime if it's in built-in code ... so we can't catch it.

But actually if you do have the completion you wouldn't care about this
specific case, but ...

johannes
