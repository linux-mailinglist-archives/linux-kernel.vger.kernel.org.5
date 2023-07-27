Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E05F7657CE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbjG0Pgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjG0Pgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:36:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D2A211C
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 08:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wvajyvPbGU4XnifnsA0utYtQNjjMry+vO/nxQQfxGKI=; b=qXBYn3RT9nW1HBAALBfe0c8nNW
        0Sr5D/TbcmCaS4FzGkuO82k4kdOBXmDoDLPKTWUjPdBx1n2MQrF9vrQ0qUJZDm3UXl2DpUaNxwQsr
        2gHLk6uXIcpUDBebDYhm2aar+NIJvYftIrLedscDTDyTXXjveQjN10cRoD8MnaLe0vrUz1ZMpNfd3
        JeC7JB/F+J1dE18VLS52wpJNxCDx7TW9ggygy5adngr8+bGMtnSBDJUVcxuAfdpl4aG77iwU9FFud
        ulGQwbqvhK3A9XpsdFJxZoO6x4LmhjGOmy3ltPd6joWkja821v46R2OaFW4P2edPNutDFWJ0Kxqgg
        bhxTewMg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qP32g-00Fz38-1g;
        Thu, 27 Jul 2023 15:36:42 +0000
Date:   Thu, 27 Jul 2023 08:36:42 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     Scott Branden <sbranden@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russ Weight <russell.h.weight@intel.com>,
        linux-kernel@vger.kernel.org,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Zhengchao Shao <shaozhengchao@huawei.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        Takashi Iwai <tiwai@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Dan Carpenter <error27@gmail.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Subject: Re: [PATCH RESEND v4 1/1] test_firmware: fix some memory leaks and
 racing conditions
Message-ID: <ZMKPCtftDQnfakId@bombadil.infradead.org>
References: <20230421185205.28743-1-mirsad.todorovac@alu.unizg.hr>
 <ZEgbkoSjHcVLcCcp@bombadil.infradead.org>
 <e9af482f-5b8a-70c0-d767-e98703cd1b03@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9af482f-5b8a-70c0-d767-e98703cd1b03@alu.unizg.hr>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 08:16:17AM +0200, Mirsad Todorovac wrote:
> On 25.4.2023. 20:27, Luis Chamberlain wrote:
> > On Fri, Apr 21, 2023 at 08:52:06PM +0200, Mirsad Goran Todorovac wrote:
> > > Some functions were called both from locked and unlocked context, so
> > > the lock was dropped prematurely, introducing a race condition when
> > > deadlock was avoided.
> > > 
> > > Having two locks wouldn't assure a race-proof mutual exclusion.
> > > 
> > > __test_dev_config_update_bool(), __test_dev_config_update_u8() and
> > > __test_dev_config_update_size_t() unlocked versions of the functions
> > > were introduced to be called from the locked contexts as a workaround
> > > without releasing the main driver's lock and causing a race condition.
> > > 
> > > This should guarantee mutual exclusion and prevent any race conditions.
> > > 
> > > Locked versions simply allow for mutual exclusion and call the unlocked
> > > counterparts, to avoid duplication of code.
> > > 
> > > trigger_batched_requests_store() and trigger_batched_requests_async_store()
> > > now return -EBUSY if called with test_fw_config->reqs already allocated,
> > > so the memory leak is prevented.
> > > 
> > > The same functions now keep track of the allocated buf for firmware in
> > > req->fw_buf as release_firmware() will not deallocate this storage for us.
> > > 
> > > Additionally, in __test_release_all_firmware(), req->fw_buf is released
> > > before calling release_firmware(req->fw),
> > > foreach test_fw_config->reqs[i], i = 0 .. test_fw_config->num_requests-1
> > > 
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: Luis Chamberlain <mcgrof@kernel.org>
> > > Cc: Russ Weight <russell.h.weight@intel.com>
> > > Cc: Tianfei zhang <tianfei.zhang@intel.com>
> > > Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > > Cc: Zhengchao Shao <shaozhengchao@huawei.com>
> > > Cc: Colin Ian King <colin.i.king@gmail.com>
> > > Cc: linux-kernel@vger.kernel.org
> > > Cc: Takashi Iwai <tiwai@suse.de>
> > > Cc: Kees Cook <keescook@chromium.org>
> > > Cc: Scott Branden <sbranden@broadcom.com>
> > > Cc: Luis R. Rodriguez <mcgrof@kernel.org>
> > > Suggested-by: Dan Carpenter <error27@gmail.com>
> > > Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
> > 
> > Mirad, thanks for this work, good stuff! So the patch just needs to be
> > adjust with:
> > 
> > Fixes: 7feebfa487b92 ("test_firmware: add support for request_firmware_into_buf"
> > Cc: stable@vger.kernel.org # v5.4
> > 
> > Then, can you split the patch in two, one which fixes the memory leaks
> > and another that deals with the mutexes. The second patch might be a fix
> > for the original code but I can't tell until I see the changes split out.
> > 
> > The commit log should account for the memory leak and be clear how it
> > happens. The other commit log for the second patch should clarify what
> > it fixes and why as well.
> 
> It seems to me that there is something wrong with the patchwork, as this commit
> had not yet appeared in 5.4 LTS stable tree?

Did you resend a new v5 with the requested changes?

  Luis
