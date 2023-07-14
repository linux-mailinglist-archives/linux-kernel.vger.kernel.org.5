Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC40C7543A0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 22:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236343AbjGNUQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 16:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236334AbjGNUQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 16:16:27 -0400
Received: from mx4.securetransport.de (mx4.securetransport.de [178.254.6.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD713AA5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 13:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1689365744;
        bh=6Vz4HbwTlKTkRlDypmngwc4b3WNL/9oiTuJhCecHFfg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Bft57Uh8WIbMB24p3nIB3K3Sz3E+rMX1MIEq31Vz3s6ifAD2Cp4UC3lGa4/Pm2HuI
         0PWlEaNRUbydn616UIRuAwQpx5XoQhC1G9a9wSWE4xEdr6lnqfeNvZ7koPyTJA2qEO
         v3skREFOQpjx2RBgpkc0VEreB416Lvl09/Z+o2GqDqDleYky7VMnm92v8q6OgxDvaY
         o45N2ezFpNkmpXh95n0IYEkK0QZ34Y6YiuvP4gPCrrW44elGVylz5K+ozNZokr3hHC
         sVP2FzYLCkH5EFBglXIwOPdX+608EIfEeajOfAXEOhgN7S1keqpq6hv7I6lXsQ8jpY
         Nz3D25gHIv6aw==
X-secureTransport-forwarded: yes
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To:     Mark Brown <broonie@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Marek Vasut <marex@denx.de>,
        kernel <kernel@dh-electronics.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V5] regulator: da9062: Make the use of IRQ optional
Thread-Topic: [PATCH V5] regulator: da9062: Make the use of IRQ optional
Thread-Index: AQHZtWtRfWVqFQFEA06/3ZItgT3fA6+3fyIAgAA0IHCAABAkAIABu/qQgAADqgCAABCCYA==
Date:   Fri, 14 Jul 2023 20:15:40 +0000
Message-ID: <d7718a5bb2384bdd96a2cc612ae3640a@dh-electronics.com>
References: <20230713090328.3879-1-cniedermaier@dh-electronics.com>
 <d8f60e51-2d62-4370-9032-51eda744239d@sirena.org.uk>
 <9629970cc2c3452e83a43660823319e5@dh-electronics.com>
 <8558f2aa-09fd-4cd3-ae1e-c80893e00aa1@sirena.org.uk>
 <c9759811145747f98462388f63358dd6@dh-electronics.com>
 <d80b10d3-7c4a-4430-8467-4672e3824a04@sirena.org.uk>
In-Reply-To: <d80b10d3-7c4a-4430-8467-4672e3824a04@sirena.org.uk>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Brown [mailto:broonie@kernel.org]
Sent: Friday, July 14, 2023 9:17 PM
> On Fri, Jul 14, 2023 at 07:03:28PM +0000, Christoph Niedermaier wrote:
>> From: Mark Brown [mailto:broonie@kernel.org]
>> Sent: Thursday, July 13, 2023 6:34 PM
>>> On Thu, Jul 13, 2023 at 03:36:38PM +0000, Christoph Niedermaier wrote:
>>>> From: Mark Brown [mailto:broonie@kernel.org]
>=20
>>>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>>> Link: https://lore.kernel.org/oe-kbuild-all/202303082246.GuLdPL0t-lk=
p@intel.com/
>=20
>>> That doesn't mean you should include tags like this, it makes it look
>>> like they reported the commit...
>=20
>> Thanks for helping me. May I asked which tags are you referring to here?
>=20
> The ones quoted above.

The kernel test robot wrote:
[...]
If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303082246.GuLdPL0t-lkp@int=
el.com/
[...]

Maybe that misled me.

Regards
Christoph
