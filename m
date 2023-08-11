Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9F5779910
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 23:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236722AbjHKVAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 17:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236419AbjHKVAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 17:00:03 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78092171D;
        Fri, 11 Aug 2023 13:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=h66CWxQYAMWCNdMmf3WZlar/AFIE8iaAwaZYcO0web0=; b=vCmnURmZMX7euyR0q2yzsdxxp+
        udERDTh0uSnfW6jVv9v35+ahV+Jfz5vsNYM91Qo6w92HkJzaidE1nM1GCrOoZNl9kRRF2b13aFDRV
        n2wD+2AsQN/6zpa6dl02HJO77p8r/B0aOz9ANhFn2UiYyxvEa82z2tieNtUsCqSs1Vkk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qUZEC-003qOt-CK; Fri, 11 Aug 2023 22:59:24 +0200
Date:   Fri, 11 Aug 2023 22:59:24 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Alfred Lee <l00g33k@gmail.com>
Cc:     netdev@vger.kernel.org, f.fainelli@gmail.com, olteanv@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, sgarzare@redhat.com, AVKrasnov@sberdevices.ru,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: mv88e6xxx: Wait for EEPROM done before HW
 reset
Message-ID: <6ed334ea-3670-4620-8653-baf70de145f1@lunn.ch>
References: <CANZWyGJDC6GMf1L+JqPEWv_c1ydnYh6rmjAY3+wrNtDOevALQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANZWyGJDC6GMf1L+JqPEWv_c1ydnYh6rmjAY3+wrNtDOevALQA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 01:30:20PM -0700, Alfred Lee wrote:
> If the switch is reset during active EEPROM transactions, as in
> just after an SoC reset after power up, the I2C bus transaction
> may be cut short leaving the EEPROM internal I2C state machine
> in the wrong state. When the switch is reset again, the bad
> state machine state may result in data being read from the wrong
> memory location causing the switch to enter unexpect mode
> rendering it inoperational.
> 
> Fixes: 8abbffd27ced ("net: dsa: mv88e6xxx: Wait for EEPROM done after HW
> reset")
> Signed-off-by: Alfred Lee <l00g33k@gmail.com>
> ---
> drivers/net/dsa/mv88e6xxx/chip.c | 8 ++++++++
> 1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/
> chip.c
> index c7d51a539451..7af2f08a62f1 100644
> --- a/drivers/net/dsa/mv88e6xxx/chip.c
> +++ b/drivers/net/dsa/mv88e6xxx/chip.c
> @@ -3034,6 +3034,14 @@ static void mv88e6xxx_hardware_reset(struct
> mv88e6xxx_chip *chip)
> /* If there is a GPIO connected to the reset pin, toggle it */
> if (gpiod) {
> + /* If the switch has just been reset and not yet completed
> + * loading EEPROM, the reset may interrupt the I2C transaction
> + * mid-byte, causing the first EEPROM read after the reset
> + * from the wrong location resulting in the switch booting
> + * to wrong mode and inoperable.
> + */
> + mv88e6xxx_g1_wait_eeprom_done(chip);
> +
> gpiod_set_value_cansleep(gpiod, 1);
> usleep_range(10000, 20000);
> gpiod_set_value_cansleep(gpiod, 0);

Hi Alfred

It looks like all the white spacing in the email has been
destroyed. Please check your mail configuration. You might want to
email the patch to only yourself, and then make sure it cleanly
applies via 'git am'

    Andrew

---
pw-bot: cr
