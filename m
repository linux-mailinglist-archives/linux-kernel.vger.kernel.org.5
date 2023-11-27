Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABDFF7FA8B6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 19:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbjK0SQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 13:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjK0SQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 13:16:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9FA198
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 10:16:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F414FC433C7;
        Mon, 27 Nov 2023 18:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701108999;
        bh=ZknOUBLMKSnRYUPIRq8z2I449mev8BtispzZPXU/eig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kewa8/8Vl2ljXIy4nV+J1uPW+QaBzWTnojvmc6n1wZ0fh8aYVd1FF+Wa+ehCU6cCb
         Lm5wSwE9Mqww/+ERO2mqVTWzX2Q6sKal5D5DQT9vhIGAD+FywKW9LaPs0uDLWMYIrT
         Ovbx7TYwtMv98xvd2Ub5hZhc8qXk9sTeGxLJ3/uTFNdU8n+6M3WT32Ch5Mihc/8KG4
         ay7Dcqo8FGMK82ajk5emkwHnU48rwI6XSreZWEXOsrlQlsY+LxtaGll1dxtSvOBcjn
         7A8NwlWiclO/3Cy0ESIWpAn/M5j1VoVqfM/a4mNPZbu5P67MVzwTGRrq8fEh1NeBRC
         o0GPJy50udFhw==
Date:   Mon, 27 Nov 2023 11:16:36 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     "Jim.Lin" <jim.chihjung.lin@gmail.com>
Cc:     axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        jim.lin@siliconmotion.com, cj.chen@siliconmotion.com,
        david.yeh@siliconmotion.com, hardaway.tseng@sk.com
Subject: Re: [PATCH] Merge tag: Fixed an issue where it takes more than 20
 mins for SK Hynix BC901 to switch to developer mode on Chromebook
Message-ID: <ZWTdBKLU32mEc70A@kbusch-mbp.dhcp.thefacebook.com>
References: <20231123100642.40923-1-jim.lin@siliconmotion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123100642.40923-1-jim.lin@siliconmotion.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 06:06:42PM +0800, Jim.Lin wrote:
> SK Hynix BC901 drive write zero will cause Chromebook takes more than 20 mins to switch to developer mode
> "disable wrtie zero" can fix this issue and Sk Hynix has been verified.
> 
> Signed-off-by: Jim.Lin <jim.lin@siliconmotion.com>

For the changelog, let's abbreviate the subject to something like:

  "nvme-pci: disable write zeroes for SK Hynix BC901"

> @@ -3394,6 +3394,8 @@ static const struct pci_device_id nvme_id_table[] = {
>  		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
>  	{ PCI_DEVICE(0x1c5c, 0x174a),   /* SK Hynix P31 SSD */
>  		.driver_data = NVME_QUIRK_BOGUS_NID, },
> +	{ PCI_DEVICE(0x1c5c, 0x1D59),   /* SK Hynix BC901 */
> +		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },

Could we get an "Ack" from the vendor?
