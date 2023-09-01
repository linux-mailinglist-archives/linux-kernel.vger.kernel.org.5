Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C23790269
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 21:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350510AbjIATJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 15:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238245AbjIATJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 15:09:30 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADC3E6A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 12:09:28 -0700 (PDT)
Date:   Fri, 01 Sep 2023 19:09:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1693595363; x=1693854563;
        bh=ImkVTB6Eef9MpGOG02YDoPGVu4sTlusc1n2LFTxU49o=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=cHRXi79fRe+xLYXflhEeHm4R1Zg/AtyB5Qn7H2iPavusBbXSVvs62ncqEgfT5plyW
         2pPTeByThBA+37ie6AI2Rr1YC8TXoI0qcUzESr9uzqQpI2Q2DzE7mn/2cMX/BeTb9K
         T9JuB1uZv/VOQZlX7y84xNvJCTNhpMFQo/FbAX+8QPf0DKCrgeCItw8jNsiLU2tSmG
         rl+yUO5136qGxBMwr1IsEwIC53tSihJ4EZJG7iNh/4+tWK9abFzvMDBgkXSaZ5nx8X
         DI7kbZSP0YQiN3W9aDaywUnIGVmFfhc+GM3wbbBZd4eVyKeMF0OUJuRhLrjftCYFN9
         /btZEyqAcsEtw==
To:     Johannes Roith <johannes@gnu-linux.rocks>
From:   Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc:     ak@it-klinger.de, andi.shyti@kernel.org,
        benjamin.tissoires@redhat.com, christophe.jaillet@wanadoo.fr,
        jikos@kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH v5] hid-mcp2200: added driver for GPIOs of MCP2200
Message-ID: <87ledpvhgm.fsf@protonmail.com>
Feedback-ID: 26003777:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 31 Aug, 2023 20:53:43 +0200 "Johannes Roith" <johannes@gnu-linux.ro=
cks> wrote:
> Hi Rahul,
>
> thanks for the feedback, I will add it to the driver.
>
>> My personal recommendation is to just have a single DMA buffer allocated
>> for the mcp2200 instance rather than having to call the allocator and
>> release the memory per command.
>
> I added an 16-byte Array hid_report to the mcp2000 struct. When I need th=
e
> report, I do the following:
>
> struct mcp_set_clear_outputs *cmd;
>
> mutex_lock(&mcp->lock);
> cmd =3D (struct mcp_set_clear_outputs *) mcp->hid_report
>
> Do you think this is a valid implementation or do I really have to add a
> pointer to the mcp2200 struct instead of the 16 byte array and allocate
> another 16 byte for it in the probe function?

This works fine since the mcp2000 struct will be dynamically allocated.
The reason I went with a separate allocation for the buffer was just to
make it explicitly clear that no matter how a thunderstrike instance is
set up, the buffer will need to be dynamically allocated for hid
requests.

>> The reason you run into this is likely because of the action added to
>> devm conflicting with hid_device_remove....
>>
>> I recommend not depending on devm for teardown rather than making a stub
>> remove function to work around the issue.

I have reinserted the relevant code from the core hid stack in my
previous email since it's important for this discussion.

    static void hid_device_remove(struct device *dev)
    {
      struct hid_device *hdev =3D to_hid_device(dev);
      struct hid_driver *hdrv;

      down(&hdev->driver_input_lock);
      hdev->io_started =3D false;

      hdrv =3D hdev->driver;
      if (hdrv) {
        if (hdrv->remove)
          hdrv->remove(hdev);
        else /* default remove */
          hid_hw_stop(hdev);

  hid_device_remove will call hid_hw_stop and so will
  mcp2200_hid_unregister because of the devm action you added.

>
> I am not sure, if I have understand this correctly, but basically I alrea=
dy
> have a stub remove function (which is empty). First the remove function g=
ets
> called, then the unregister function and everything is cleaned up correct=
ly.
> Did I get this right or do you have any other recommendation for me?

Let me try to break down the problem first.

1. You add mcp2200_hid_unregister to the devm actions for clean up the
   device.
2. mcp2200_hid_unregister will call hid_hw_close and hid_hw_stop,
   tearing down the device.
3. hid_device_remove is invoked when the device is removed, which
   already calls hid_hw_stop when no remove function is registered (the
   expectation is the device is simple when this is the case)
4. This leads to the device already being torn down, which leads to the
   exception seen when the devm kicks in and mcp_hid_unregister is then
   triggered.
5. Using an empty remove function resolves this but indicates the driver
   has an inappropriate devm action in my opinion/has problematic
   design.

I am saying that using an empty remove function to work
around the problem is not an upstream-able solution in my opinion.

Given this, I think its best to not use devm in this can and manually
handle cleanup, so you do not have a stub remove function and take
control of the teardown.

> So, do I need any adaptions, or can we go with the empty remove function?

That said, maybe someone else can chime in on this to see if this aligns
with others' preferences? At the very least though if others feel using
an empty remove function is ok, I think the comment in the remove
function needs to updated to add clear detail about the issue than what
is currently provided. That said, I am very much against using an empty
remove function to work around problematic devm practices.

 =09/*
 =09 * With no remove function you sometimes get a segmentation fault when
 =09 * unloading the module or disconnecting the USB device
 =09 */

--
Thanks,

Rahul Rameshbabu

