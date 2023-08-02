Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4235C76D4CF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbjHBRLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjHBRLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:11:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1674C1729
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:11:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D08D61A55
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 17:11:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBBFDC433C9;
        Wed,  2 Aug 2023 17:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690996292;
        bh=F9DfBBNJp0Eix0jh6pJTYP+XC+GhI7pk3Lklg3YvhM8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SXgEDL8m3jCqhZzg5zTecOFTi++w77uKuUcBnuS6E1Q8IKSmJqxSZYwyIQpSRcfvM
         oDYMqK1WqTM9+2OH7+cVn43cTCBx8fz0K4IEe7oFb6xdKpDee5pZz3N23Z6YKlC4IY
         e5dlJjs0eC4uhKTMD0sMP0+54F30GdCGEvfcP4tRs7IYWF8q4Yy1O0fen89A5vTFdb
         RV+/qJX3PxG72zOrXdttj6YmaAtoeQxaYE0KSK7BecVHJRq5Yek1lq0h32WUU8azZC
         jUNk4sGsSPHSzUh08oNhWPjZa+EdfqT08RJB114tL3uc1RdvYXjpgUn2rC4uDDtYpP
         DWAtwORDLA7Dw==
MIME-Version: 1.0
Date:   Wed, 02 Aug 2023 19:11:27 +0200
From:   Michael Walle <mwalle@kernel.org>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        =?UTF-8?Q?Marek_B?= =?UTF-8?Q?eh=C3=BAn?= <kabel@kernel.org>,
        Xu Liang <lxu@maxlinear.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH net-next v3 02/11] net: phy: introduce
 phy_has_c45_registers()
In-Reply-To: <ZMp/B2U/qaI/VQDN@shell.armlinux.org.uk>
References: <20230620-feature-c45-over-c22-v3-0-9eb37edf7be0@kernel.org>
 <20230620-feature-c45-over-c22-v3-2-9eb37edf7be0@kernel.org>
 <7be8b305-f287-4e99-bddd-55646285c427@lunn.ch>
 <867ae3cc05439599d63e4712bca79e27@kernel.org>
 <cf999a14e51b7f2001d9830cc5e11016@kernel.org>
 <ZMkddjabRonGe7Eu@shell.armlinux.org.uk>
 <bce942b71db8c4b9bf741db517e7ca5f@kernel.org>
 <ZMkraPZvWWKhY8lT@shell.armlinux.org.uk>
 <b0e5fbe28757d755d814727181c09f32@kernel.org>
 <ZMp/B2U/qaI/VQDN@shell.armlinux.org.uk>
Message-ID: <3fa8d14f0a989af971d61af01b13fd8b@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2023-08-02 18:06, schrieb Russell King (Oracle):
> On Wed, Aug 02, 2023 at 05:33:20PM +0200, Michael Walle wrote:
>> Am 2023-08-01 17:57, schrieb Russell King (Oracle):
>> > On Tue, Aug 01, 2023 at 05:20:22PM +0200, Michael Walle wrote:
>> > > > In the case of the above (the code in __phy_read_mmd()), I wouldn't
>> > > > at least initially change the test there.
>> > > >
>> > > > phydev->is_c45 will only be true if we probed the PHY using clause
>> > > > 45 accesses. Thus, it will be set if "the bus supports clause 45
>> > > > accesses" _and_ "the PHY responds to those accesses".
>> > > >
>> > > > Changing that to only "the bus supports clause 45 accesses" means
>> > > > that a PHY supporting only clause 22 access with indirect clause
>> > > > 45 access then fails if it's used with a bus that supports both
>> > > > clause 22 and clause 45 accesses.
>> > >
>> > > Yeah of course. It was more about the naming, but I just realized
>> > > that with mdiobus_supports_c45() you can't access the original
>> > > "is_c45" property of the PHY. So maybe this patch needs to be split
>> > > into two to get rid of .is_c45:
>> > >
>> > > First a mechanical one:
>> > > phy_has_c45_registers() {
>> > >    return phydev->is_c45;
>> > > }
>> >
>> > Andrew's objection was that "phy_has_c45_registers" is a misnomer, and
>> > suggested "_transfers" instead - because a PHY can have C45 registers
>> > that are accessible via the indirect registers in C22 space.
>> 
>> I'm confused now. Andrew suggested to split it into four different
>> functions:
>> 
>> phy_has_c22_registers()
>> phy_has_c45_registers()
>> phy_has_c22_transfers()
>> phy_has_c45_transfers()
> 
> Honestly, I don't think we can come up with tests that satisfy all of
> these. Particularly the question whether a PHY has c45 registers or
> not is a difficult one, as there is no sane way to determine that with
> a clause 22 PHY.

And that is exactly the one which Andrew suggested to use for almost all
cases. It doesn't make sense to me to introduce that function if it 
can't
really be made to return a correct value (in a later patch).

> I'm also not sure what use the c22 transfers one would be, since if a
> PHY doesn't have c22 registers, then that's probably all we need to
> know.
> 
>> Without a functional change. That is, either return phydev->is_c45
>> or the inverse.
> 
> I think I've already explained why !phydev->is_c45 can't be interpeted
> as a PHY having C22 registers, but let me restate. It is _entirely_
> possible for a PHY to have C45 registers _and_ C22 registers, and
> that is indicated by bit 0 of the devices-in-package field.
> 
>> You seem to suggest to use either
>> phy_supports_c45_transfers() or
>> phy_has_c22_registers()
>> 
>> I'm not sure how to continue now.
>> 
>> > I'd go one further:
>> >
>> > static bool phy_supports_c45_transfers(struct phy_device *phydev)
>> > {
>> > 	return phydev->is_c45;
>> > }
>> >
>> > Since that covers that (a) the bus needs to support C45 transfers and
>> > (b) the PHY also needs to respond to C45 transfers.
>> >
>> > If we want to truly know whether a clause 22 PHY has clause 45
>> > registers, that's difficult to answer, because then you're into the
>> > realms of "does this PHY implement the indirect access method" and
>> > we haven't been keeping track of that for the PHYs we have drivers
>> > for - many will do, but it's optional in clause 22. The problem is
>> > that when it's not implemented, the registers could be serving some
>> > other function.
>> >
>> > > phy_has_c22_registers() {
>> > >   return !phydev->is_c45;
>> > > }
>> >
>> > The reverse is not true, as clause 45 PHYs can also support clause 22
>> > registers - from 802.3:
>> >
>> >  "For cases where a single entity combines Clause 45 MMDs with  Clause
>> > 22
>> >  registers, then the Clause 22 registers may be accessed using the
>> > Clause
>> >  45 electrical interface and the Clause 22 management frame structure."
>> >
>> >  "Bit 5.0 is used to indicate that Clause 22 functionality has been
>> >  implemented within a Clause 45 electrical interface device."
>> >
>> > Therefore, this would more accurately describe when Clause 22 registers
>> > are present for a PHY:
>> >
>> > static bool phy_has_c22_registers(struct phy_device *phydev)
>> > {
>> > 	/* If we probed the PHY without clause 45 accesses, then by
>> > 	 * definition, clause 22 registers must be present.
>> > 	 */
>> > 	if (!phydev->is_c45)
>> > 		return true;
>> >
>> > 	/* If we probed the PHY with clause 45 accesses, clause 22
>> > 	 * registers may be present if bit 0 in the Devices-in-pacakge
>> > 	 * register pair is set.
>> > 	 */
>> > 	return phydev->c45_ids.devices_in_package & BIT(0);
>> > }
>> >
>> > Note that this doesn't take account of whether the bus supports clause
>> > 22 register access - there are a number of MDIO buses that do not
>> > support such accesses, and they may be coupled with a PHY that does
>> > support clause 22 registers.
>> >
>> > I'm aware of a SFP with a Realtek PHY on that falls into this exact
>> > case, and getting that working is progressing at the moment.
>> >
>> > > For all the places Andrew said it's correct. Leave all the
>> > > other uses of .is_c45 as is for now and rework them in a
>> > > later patch to use mdiobus_supports_{c22,c45}().
>> >
>> > For the two cases in marvell10g and bcm84881, the test there for
>> > is_c45 is purely to determine "was this ID found on a PHY supporting
>> > clause 45 access" - however, in both cases, a check is made for MMDs
>> > present in devices_in_package which will fail if the PHY wasn't
>> > discovered in clause 45 mode.
>> >
>> > Note that 88x3310 does not support clause 22 access. I forget whether
>> > bcm84881 does or not.
>> 
>> So a simple "phydev->is_c45" should be enough? Why do you test
>> for the MMD presence bits?
> 
> Okay, so if quoting the bits from IEEE 802.3 doesn't provide sufficient
> explanation, I'm at a loss what would...

I'm talking about

	u32 mmd_mask = MDIO_DEVS_PMAPMD | MDIO_DEVS_AN;
	if (!phydev->is_c45 ||
	    (phydev->c45_ids.devices_in_package & mmd_mask) != mmd_mask)
		return -ENODEV;

How should that look like after this series?
