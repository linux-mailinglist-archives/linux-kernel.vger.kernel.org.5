Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F5779A36E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 08:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbjIKGWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 02:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjIKGWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 02:22:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73ED7100;
        Sun, 10 Sep 2023 23:22:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B6CC433C8;
        Mon, 11 Sep 2023 06:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694413326;
        bh=ljfyOXScKlvgCtkEpZOCDRvcS+Qur/OCIdnah/jE/wc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WM1syL1eHOTi5P0IKmRr/LCMvhpftw7JmKf/ej1ZTU3Yl8a87NiK9NzNXwZFjVKV0
         vXXvGjbHJ+RjlW3O1dCye12eUufcKwFv0r4a2zLqMPIP8/govshxM7o8bW+zBOTabG
         5Qx7x3t9s76HHsCBYkHk4WSXj2+OonlNGSSIiSoigb2vrT+fOs/yTA1e14X7dujhVT
         bnCK6LCrvCenjfu8rygCnL72DTOGe6GXohjp7M0hjSayniA2vUHQ+gmveolKoxw4VI
         ZW6IfqtkbxpGqLCQxlRLTCLh/V2/2oeigfr3VzOtw0P3Tnzvr02TY1PG3hthcWDaq7
         XNx80XZUrkBIA==
Message-ID: <b991c72c-99da-e4f2-055b-fa8b12e0efc4@kernel.org>
Date:   Mon, 11 Sep 2023 15:22:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4] ahci: libahci: clear pending interrupt status
Content-Language: en-US
To:     Szuying Chen <chensiying21@gmail.com>, Niklas.Cassel@wdc.com,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jesse1_Chang@asmedia.com.tw, Richard_Hsu@asmedia.com.tw,
        Chloe_Chen@asmedia.com.tw
References: <20230907081710.4946-1-Chloe_Chen@asmedia.com.tw>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230907081710.4946-1-Chloe_Chen@asmedia.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/23 17:17, Szuying Chen wrote:
> When a CRC error occurs, the HBA asserts an interrupt to indicate an
> interface fatal error(PxIS.IFS). The ISR clear PxIE and PxIS, then do
> error recovery. Before recovery process, HBA receives another SDB FIS
> with the error(PxIS.TFES) from device. This can't be serviced due to
> PxIE be cleared already. During error recovery process, the HBA can't
> issue any new command after setting PxCMD.ST to 1 due to PxIS.TFES
> still alive.
> 
> According to AHCI 1.3.1 - section 6.2.2 specification. Fatal errors
> (signified by the setting of PxIS.HBFS, PxIS.HBDS, PxIS.IFS or PxIS.TFES)
> will cause the HBA to enter the ERR:Fatal state. In this state, the HBA
> shall not issue any new commands.
> 
> To avoid this, introduce the function ahci_port_clear_pending_irq()
> to clear pending interrupts before executing a COMRESET. This follows
> the AHCI 1.3.1 - section 6.2.2.2 specification.
> 
> Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>

Applied to for-6.6-fixes with some tweaks to the commit message.
Thanks !

-- 
Damien Le Moal
Western Digital Research

