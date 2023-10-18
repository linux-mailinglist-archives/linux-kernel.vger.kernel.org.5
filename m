Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7DB7CD6F5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjJRIuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjJRIui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:50:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A366EFD;
        Wed, 18 Oct 2023 01:50:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00BEC433C8;
        Wed, 18 Oct 2023 08:50:33 +0000 (UTC)
Message-ID: <4a74a40c-ee3c-4563-87d1-27e859eb6982@xs4all.nl>
Date:   Wed, 18 Oct 2023 10:50:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/8] Add StarFive Camera Subsystem driver
Content-Language: en-US, nl
To:     Jack Zhu <jack.zhu@starfivetech.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>, bryan.odonoghue@linaro.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-staging@lists.linux.dev,
        changhuang.liang@starfivetech.com
References: <20231008085154.6757-1-jack.zhu@starfivetech.com>
 <98297bfc-ab81-4bb5-acc3-619fdf879276@xs4all.nl>
 <bb5b776c-f1dd-f53e-079c-8048af2e73f1@starfivetech.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <bb5b776c-f1dd-f53e-079c-8048af2e73f1@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jack,

On 18/10/2023 04:37, Jack Zhu wrote:

<snip>

>>> --------------------------------------------------------------------------------
>>> Compliance test for device /dev/v4l-subdev1:
>>>
>>> Driver Info:
>>> 	Driver version   : 6.6.0
>>> 	Capabilities     : 0x00000000
>>
>> But this does not appear for v4l-subdev1.
>>
>> I can't really tell why it doesn't show that. Can you debug a little bit?
>> The code is in v4l2-compliance.cpp, line 1086:
>>
>> ent_id = mi_media_info_for_fd(media_fd, node.g_fd(), &is_invalid, &node.function);
>>
>> The mi_media_info_for_fd() function calls ioctl(media_fd, MEDIA_IOC_DEVICE_INFO, &mdinfo),
>> and that fails for some reason. It could be that media_fd is invalid (would be weird).
>>
>> This could well be a v4l2-compliance bug that you hit with this driver.
>>
> 
> On the test board, /dev/v4l-subdev1 is imx219, and the corresponding directory is
> /sys/dev/char/81:3/device. Media0 does not exist in this directory. Therefore, the media_fd
> obtained through mi_get_media_fd(node.g_fd(), node.bus_info) is invalid.
> 
> I don't know why media0 does not exist in /sys/dev/char/81:3/device?
> 

Can you try again with this v4l2-compliance patch?

I need to dig a bit deeper as to why media0 is missing, but for now try this.

Regards,

	Hans

diff --git a/utils/v4l2-compliance/v4l2-compliance.cpp b/utils/v4l2-compliance/v4l2-compliance.cpp
index 7169eefe..29475d6b 100644
--- a/utils/v4l2-compliance/v4l2-compliance.cpp
+++ b/utils/v4l2-compliance/v4l2-compliance.cpp
@@ -968,7 +968,7 @@ err:
 }

 void testNode(struct node &node, struct node &node_m2m_cap, struct node &expbuf_node, media_type type,
-	      unsigned frame_count, unsigned all_fmt_frame_count)
+	      unsigned frame_count, unsigned all_fmt_frame_count, int parent_media_fd)
 {
 	struct node node2;
 	struct v4l2_capability vcap = {};
@@ -997,8 +997,12 @@ void testNode(struct node &node, struct node &node_m2m_cap, struct node &expbuf_
 		memset(&vcap, 0, sizeof(vcap));
 	}

-	if (!node.is_media())
-		media_fd = mi_get_media_fd(node.g_fd(), node.bus_info);
+	if (!node.is_media()) {
+		if (parent_media_fd >= 0)
+			media_fd = parent_media_fd;
+		else
+			media_fd = mi_get_media_fd(node.g_fd(), node.bus_info);
+	}

 	int fd = node.is_media() ? node.g_fd() : media_fd;
 	if (fd >= 0) {
diff --git a/utils/v4l2-compliance/v4l2-compliance.h b/utils/v4l2-compliance/v4l2-compliance.h
index 7caf254b..c47f25f5 100644
--- a/utils/v4l2-compliance/v4l2-compliance.h
+++ b/utils/v4l2-compliance/v4l2-compliance.h
@@ -308,7 +308,7 @@ int check_ustring(const __u8 *s, int len);
 int check_0(const void *p, int len);
 int restoreFormat(struct node *node);
 void testNode(struct node &node, struct node &node_m2m_cap, struct node &expbuf_node, media_type type,
-	      unsigned frame_count, unsigned all_fmt_frame_count);
+	      unsigned frame_count, unsigned all_fmt_frame_count, int parent_media_fd = -1);
 std::string stream_from(const std::string &pixelformat, bool &use_hdr);

 // Media Controller ioctl tests

