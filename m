Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F088012F7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 19:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379360AbjLASpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 13:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjLASpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 13:45:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E85493
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 10:45:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF83C433C7;
        Fri,  1 Dec 2023 18:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701456307;
        bh=6ayoBSJy6iihyBHwxLrx8Luk1kVUOImElJUsiwGZ0Z0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FcqG69kPysYDU470FPhnMo9aFkTzh5UFfSP+GB7jG1Kq2MgYkKkO9/7xS41/QItmY
         GKebXgxqnFcpvOyfbJxBjKyr9N5A9UjF5UCcyDgiSAxUIUp9IvwZ+ix+on+62kKSLA
         F7mloqInbrkRAX4DPZUL3VG/kZayO0kR6UoLgpzcdpDbW+qF62RXqVpn+LTW8v/oW8
         vpsqubTRa1P6t/SiRDNShl1ShpFTrhT8bF9vrbcOzAIqFCFq6tgs9GLLlbvPi9r6QQ
         niQ7PdyMU5YSJWJzwrDgR+MFlC8rvJC0pglI1Zk9VSYE7cGdU6bIzoMCDY/dLyS5qS
         1v1SjukglLfEg==
Date:   Fri, 1 Dec 2023 10:45:05 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     kernel test robot <lkp@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Michael Walle <mwalle@kernel.org>,
        Max Schulze <max.schulze@online.de>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] netlink: Return unsigned value for nla_len()
Message-ID: <20231201104505.44ec5c89@kernel.org>
In-Reply-To: <202312010953.BEDC06111@keescook>
References: <20231130200058.work.520-kees@kernel.org>
        <20231130172520.5a56ae50@kernel.org>
        <202312010953.BEDC06111@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Dec 2023 10:17:02 -0800 Kees Cook wrote:
> > > -static inline int nla_len(const struct nlattr *nla)
> > > +static inline u16 nla_len(const struct nlattr *nla)
> > >  {
> > > -	return nla->nla_len - NLA_HDRLEN;
> > > +	return nla->nla_len > NLA_HDRLEN ? nla->nla_len - NLA_HDRLEN : 0;
> > >  } =20
> >=20
> > Note the the NLA_HDRLEN is the length of struct nlattr.
> > I mean of the @nla object that gets passed in as argument here.
> > So accepting that nla->nla_len may be < NLA_HDRLEN means
> > that we are okay with dereferencing a truncated object...
> >=20
> > We can consider making the return unsinged without the condition maybe?=
 =20
>=20
> Yes, if we did it without the check, it'd do "less" damage on
> wrap-around. (i.e. off by U16_MAX instead off by INT_MAX).
>=20
> But I'd like to understand: what's the harm in adding the clamp? The
> changes to the assembly are tiny:
> https://godbolt.org/z/Ecvbzn1a1

Hm, I wonder if my explanation was unclear or you disagree..

This is the structure:

struct nlattr {
	__u16           nla_len; // attr len, incl. this header
	__u16           nla_type;
};

and (removing no-op wrappers):

#define NLA_HDRLEN	sizeof(struct nlattr)

So going back to the code:

	return nla->nla_len > NLA_HDRLEN ? nla->nla_len - NLA_HDRLEN...

We are reading nla->nla_len, which is the first 2 bytes of the structure.
And then we check if the structure is... there?

If we don't trust that struct nlattr which gets passed here is at least
NLA_HDRLEN (4B) then why do we think it's safe to read nla_len (the
first 2B of it)?

That's why I was pointing at nla_ok(). nla_ok() takes the size of the
buffer / message as an arg, so that it can also check if looking at
nla_len itself is not going to be an OOB access. 99% of netlink buffers
we parse come from user space. So it's not like someone could have
mis-initialized the nla_len in the kernel and being graceful is helpful.

The extra conditional is just a minor thing. The major thing is that
unless I'm missing something the check makes me go =F0=9F=A4=A8=EF=B8=8F

