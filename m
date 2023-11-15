Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A78E7EBD12
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 07:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbjKOG3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 01:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbjKOG3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 01:29:15 -0500
Received: from 6.mo550.mail-out.ovh.net (6.mo550.mail-out.ovh.net [46.105.43.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89213EB
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 22:29:10 -0800 (PST)
Received: from director1.ghost.mail-out.ovh.net (unknown [10.108.16.135])
        by mo550.mail-out.ovh.net (Postfix) with ESMTP id 6740D28F02
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 05:52:54 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-p7h5p (unknown [10.109.156.181])
        by director1.ghost.mail-out.ovh.net (Postfix) with ESMTPS id B9F281FE33;
        Wed, 15 Nov 2023 05:52:52 +0000 (UTC)
Received: from RCM-web6.webmail.mail.ovh.net ([151.80.29.20])
        by ghost-submission-6684bf9d7b-p7h5p with ESMTPSA
        id KK+VK7RcVGUPGyAA34RSKA
        (envelope-from <jose.pekkarinen@foxhound.fi>); Wed, 15 Nov 2023 05:52:52 +0000
MIME-Version: 1.0
Date:   Wed, 15 Nov 2023 07:52:52 +0200
From:   =?UTF-8?Q?Jos=C3=A9_Pekkarinen?= <jose.pekkarinen@foxhound.fi>
To:     Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com,
        skhan@linuxfoundation.org, airlied@gmail.com, daniel@ffwll.ch,
        Wayne.Lin@amd.com, qingqing.zhuo@amd.com, lyude@redhat.com,
        srinivasan.shanmugam@amd.com, aurabindo.pillai@amd.com,
        sungjoon.kim@amd.com, wenjing.liu@amd.com, mikita.lipski@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v2] drm/amd/display: fix NULL dereference
In-Reply-To: <689f3862-09d5-448d-b418-fd52d7288106@amd.com>
References: <20231114152751.30167-1-jose.pekkarinen@foxhound.fi>
 <689f3862-09d5-448d-b418-fd52d7288106@amd.com>
User-Agent: Roundcube Webmail/1.4.15
Message-ID: <87904eedaf4170e2302450eaa27f57d0@foxhound.fi>
X-Sender: jose.pekkarinen@foxhound.fi
Organization: Foxhound Ltd.
X-Originating-IP: 45.151.167.10
X-Webmail-UserID: jose.pekkarinen@foxhound.fi
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 6680527099856594625
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrudefhedgvddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggffhffvvefujghffgfkgihoihgtgfesthekjhdttderjeenucfhrhhomheplfhoshorucfrvghkkhgrrhhinhgvnhcuoehjohhsvgdrphgvkhhkrghrihhnvghnsehfohighhhouhhnugdrfhhiqeenucggtffrrghtthgvrhhnpeekhfeguddufeegvdelgedtvdffgeehvddtkeevkeejvedvgeeitdefleehtdeitdenucfkphepuddvjedrtddrtddruddpgeehrdduhedurdduieejrddutddpudehuddrkedtrddvledrvddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeojhhoshgvrdhpvghkkhgrrhhinhgvnhesfhhogihhohhunhgurdhfiheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehhedtpdhmohguvgepshhmthhpohhuth
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-14 23:01, Hamza Mahfooz wrote:
> On 11/14/23 10:27, José Pekkarinen wrote:
>> The following patch will fix a minor issue where a debug message is
>> referencing an struct that has just being checked whether is null or
>> not. This has been noticed by using coccinelle, in the following 
>> output:
>> 
>> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c:540:25-29: 
>> ERROR: aconnector is NULL but dereferenced.
>> 
>> Fixes: 5d72e247e58c9 ("drm/amd/display: switch DC over to the new DRM 
>> logging macros")
> 
> You only need the first 12 characters of the hash here. I have fixed it
> for you and applied the patch in this case. But, in the future please
> test your patches against `./scripts/checkpatch.pl` before submitting
> them.

     Oops! Sorry I didn't notice! Thanks!

     José.
