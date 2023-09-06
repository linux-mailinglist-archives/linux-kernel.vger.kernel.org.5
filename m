Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BC87944F0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 23:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244666AbjIFVHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 17:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbjIFVHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 17:07:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F221010E9;
        Wed,  6 Sep 2023 14:07:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8812DC433C7;
        Wed,  6 Sep 2023 21:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694034420;
        bh=an0mR5nW8SKPBFAgxd/VoVsb+gga/Qf/UwrGGkZeZP8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=mey/NcOM/wjd1acfrlS810bTi1xacHHCj1q/+t9+AqHcg+d8nVG5ts5m5k+GWJU7k
         SYnCHQGGkR1S+o8g///Cys77gvWEe1tp95OGCkujE8WG9/dNdtbJ3L0sPS2x/oJuRT
         7vqCsB2s1udQrELIg7isaO1e6II8oOLxGFNyE0s8TpduFMvUjC52p6NB6Ujll5o4SJ
         BvLGT/EVRKRiQxtWsyrQqyjAi2b802FXuUXnZd1xk8Cnr0xW8fDnvIZgC3geSrkumq
         xmvmN3pTpzDJLk8rceNuK3E3uqmu7GOzwSssYTDPIWk6eOpfXwiy+D5u4wfFPO08sR
         5+yZfnT9Os11w==
Message-ID: <be8d0ac6da08fdb757d4bec365bc8a94.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <567a09b4-2184-1bd8-a3fc-8a5fd4d682ad@roeck-us.net>
References: <20230817225537.4053865-1-linux@roeck-us.net> <20230817225537.4053865-3-linux@roeck-us.net> <6991631008bab403e957534d6d05360c.sboyd@kernel.org> <afa30d68-4f53-4903-b470-0d337c9aa7aa@roeck-us.net> <8bde38a9e447fc4c3a8834220a3073fa.sboyd@kernel.org> <567a09b4-2184-1bd8-a3fc-8a5fd4d682ad@roeck-us.net>
Subject: Re: [PATCH v2 2/7] rtc: alarmtimer: Use maximum alarm time offset
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Benson Leung <bleung@chromium.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <jstultz@google.com>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Guenter Roeck <linux@roeck-us.net>
Date:   Wed, 06 Sep 2023 14:06:58 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Guenter Roeck (2023-08-30 21:23:54)
> On 8/30/23 14:16, Stephen Boyd wrote:
> >=20
> > We fail alarmtimer creation in the case that CONFIG_RTC_CLASS=3Dn or wh=
en
> > there isn't an rtc. See alarmtimer_get_rtcdev() and how it is called. I
> > doubt it ever really happens in practice, but it looks possible to
> > simulate by unbinding the rtc device driver.
>=20
> Thanks for the clarification. That really makes me wonder what happens
> if an rtc device is unregistered. The .remove_dev callback of
> alarmtimer_rtc_interface is not populated, and rtc_dev is never cleared.
> That means unbinding an rtc device driver should result in a crash.
> Am I missing something ?
>=20

Yeah it looks like a potential problem, but most likely nobody actually
removes the rtc device from the system. It would be good to handle this
case in a followup patch anyway though.
