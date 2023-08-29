Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B1178C8EC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 17:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236476AbjH2Pyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 11:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbjH2PyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 11:54:16 -0400
Received: from mail.enpas.org (zhong.enpas.org [IPv6:2a03:4000:2:537::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFD0113;
        Tue, 29 Aug 2023 08:54:12 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.enpas.org (Postfix) with ESMTPSA id 573A710134F;
        Tue, 29 Aug 2023 15:54:07 +0000 (UTC)
Message-ID: <ec4d07de-4944-a7ea-2b74-c4162af75b16@enpas.org>
Date:   Wed, 30 Aug 2023 00:53:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/2] hid-sony: DS3: Report analog buttons for Sixaxis
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Vicki Pfau <vi@endrift.com>, Pavel Rojtberg <rojtberg@gmail.com>,
        Roderick Colenbrander <roderick@gaikai.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230826152111.13525-1-max@enpas.org>
 <20230826152111.13525-3-max@enpas.org>
Content-Language: en-US
From:   Max Staudt <max@enpas.org>
In-Reply-To: <20230826152111.13525-3-max@enpas.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/23 00:21, Max Staudt wrote:
> This change exposes these buttons as axes in a way that is as backwards
> compatible and as close to the Linux gamepad spec as possible.
> 
> [...]
> 
>   - The D-Pad as ABS_HAT0X/ABS_HAT0Y, -255 to 255


One further idea:

The DualShock 3 reports all 4 D-pad buttons separately, and hid-sony currently reports them as discrete digital buttons to userspace.


Would it be better to do the same with the analog buttons, i.e. to report the 4 measurements as discrete axes, rather than the current patch's approach of merging them into two logical axes?

Of course, this would require 4 more axes, this would not fit into any existing scheme, and since we've run out of ABS_MISC+n at this point, this could be a further reason for officially reserving a range of axes for analog buttons. Something like:


#define ABS_BTN_SOUTH		0x40
#define ABS_BTN_A		ABS_BTN_SOUTH
#define ABS_BTN_EAST		0x41
#define ABS_BTN_B		ABS_BTN_EAST
#define ABS_BTN_C		0x42
#define ABS_BTN_NORTH		0x43
#define ABS_BTN_X		ABS_BTN_NORTH
#define ABS_BTN_WEST		0x44
#define ABS_BTN_Y		ABS_BTN_WEST
#define ABS_BTN_Z		0x45

#define ABS_BTN_DPAD_UP		0x46
#define ABS_BTN_DPAD_DOWN	0x47
#define ABS_BTN_DPAD_LEFT	0x48
#define ABS_BTN_DPAD_RIGHT	0x49

#define ABS_MAX			0x4f
#define ABS_CNT			(ABS_MAX+1)



Max

