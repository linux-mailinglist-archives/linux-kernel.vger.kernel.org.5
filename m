Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8266D7675AE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 20:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbjG1SlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 14:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjG1SlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 14:41:00 -0400
Received: from kozue.soulik.info (kozue.soulik.info [IPv6:2001:19f0:7000:8404:5400:ff:fe00:d7d6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D99649EB;
        Fri, 28 Jul 2023 11:40:32 -0700 (PDT)
Received: from [192.168.10.7] (unknown [10.0.12.132])
        by kozue.soulik.info (Postfix) with ESMTPSA id 0D21A300F2B;
        Sat, 29 Jul 2023 03:39:54 +0900 (JST)
DKIM-Filter: OpenDKIM Filter v2.11.0 kozue.soulik.info 0D21A300F2B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soulik.info; s=mail;
        t=1690569600; bh=QEElF6mACLvmrZMLZzPmyID0hHQhIMgI9+CjeYDQ86c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rp8mROI7RfAp4AoFfb06h8q3qJg0KW9F5F6Q6OVMyFs/7JhUNUJ85Ju5FE1um+XnD
         N2KzBMvZZ2SxbQ4AstUvjTK5IhOAnKKoMef6RuSCGdFSOGZBoahOn84Xtr+e8KYG6x
         a3jor715vX/5nE8Pyr40Zo1TNCFGY7jIBPOMF1VA=
Message-ID: <ca0d1868-feec-75bf-69b2-4b105ca1bf77@soulik.info>
Date:   Sat, 29 Jul 2023 02:40:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 2/9] media: vivid: Convert to v4l2_ext_pix_format
Content-Language: en-US
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     linux-media@vger.kernel.org,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        randy.li@synaptics.com, Brian.Starkey@arm.com,
        boris.brezillon@collabora.com, frkoenig@chromium.org,
        hans.verkuil@cisco.com, hiroh@chromium.org, hverkuil@xs4all.nl,
        kernel@collabora.com, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org, mchehab@kernel.org,
        narmstrong@baylibre.com, sakari.ailus@iki.fi,
        stanimir.varbanov@linaro.org,
        Helen Koike <helen.koike@collabora.com>
References: <20230206043308.28365-1-ayaka@soulik.info>
 <20230206043308.28365-3-ayaka@soulik.info>
 <20230713103912.favcnhqwjkzvsa6b@chromium.org>
 <46d15120-6e19-e224-47f3-e0dcbf0aeda5@soulik.info>
 <bbb6660439bb66bd9d81bb8031d9062d3c03fdf0.camel@ndufresne.ca>
 <CAAFQd5Dn97Q-tSUvT5HncV0GTQQYrBYjF-1vsmB6VPv=zrkRkw@mail.gmail.com>
From:   Randy Li <ayaka@soulik.info>
In-Reply-To: <CAAFQd5Dn97Q-tSUvT5HncV0GTQQYrBYjF-1vsmB6VPv=zrkRkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/7/28 15:22, Tomasz Figa wrote:
> On Fri, Jul 21, 2023 at 5:10 AM Nicolas Dufresne <nicolas@ndufresne.ca> wrote:
>> Le mardi 18 juillet 2023 à 00:00 +0800, Randy Li a écrit :
>>> On 2023/7/13 18:39, Tomasz Figa wrote:
>>>> On Mon, Feb 06, 2023 at 12:33:01PM +0800, ayaka wrote:
>>>>> From: Helen Koike <helen.koike@collabora.com>
>>>>>
>>>>> Simplify Multi/Single planer API handling by converting to v4l2_ext_pix_format.
>>>>>
>>>>> Duplicate v4l2_ioctl_ops for touch devices. This is done to force the
>>>>> framework to use the ext hooks when the classic Api is used from
>>>>> userspace in Vid devices, and to keep touch devices with classic hook.
>>>>>
>>>>> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
>>>>> Signed-off-by: Helen Koike <helen.koike@collabora.com>
>>>>> ---
>>>>> Changes in v7:
>>>>> - Force the userspace using the new APIs to operate non-touch drivers.
>>>> The primary objective of Linux development is not to break the
>>>> userspace. We can't just remove the old API, especially not from
>>>> existing drivers.
>>> Maybe I should create a new virtual driver here? It is impossible to
>>> support the new fourcc modifier with the old APIs.
>> For MPLANE, where backward compatibility was built into libv4l2 LD_PRELOAD
>> wrapper,
> Could you refresh my memory on what kind of backwards compatibility we
> had in libv4l2? Was that to make it possible to use new MPLANE-only
> drivers with old applications?

lib/libv4l-mplane/libv4l-mplane.c

I think application don't need to know the new MPLANE variant of pixel 
formats or queue type.

>> it simply failed the cases that could not be supported (non contiguous
>> planes).
>>
>> regards,
>> Nicolas
>>
>>>> [snip]
>>>>>    int vivid_try_fmt_vid_cap(struct file *file, void *priv,
>>>>> -                 struct v4l2_format *f)
>>>>> +                   struct v4l2_ext_pix_format *f)
>>>>>    {
>>>>> - struct v4l2_pix_format_mplane *mp = &f->fmt.pix_mp;
>>>>> - struct v4l2_plane_pix_format *pfmt = mp->plane_fmt;
>>>>>            struct vivid_dev *dev = video_drvdata(file);
>>>>> + struct v4l2_plane_pix_format *pfmt = f->plane_fmt;
>>>>>            const struct vivid_fmt *fmt;
>>>>>            unsigned bytesperline, max_bpl;
>>>>>            unsigned factor = 1;
>>>>>            unsigned w, h;
>>>>>            unsigned p;
>>>>> - bool user_set_csc = !!(mp->flags & V4L2_PIX_FMT_FLAG_SET_CSC);
>>>> Why is this condition being removed?
>>> Because the v4l2_ext_pix has a struct for the colorspace?
>>>
>>> Would you like the idea that driver exports a buffer contains all the
>>> info for an enumeration ?
>>>
>>>> Best regards,
>>>> Tomasz
>>>>
>>>>> - fmt = vivid_get_format(dev, mp->pixelformat);
>>>>> + fmt = vivid_get_format(dev, f->pixelformat);
>>>>>            if (!fmt) {
>>>>>                    dprintk(dev, 1, "Fourcc format (0x%08x) unknown.\n",
>>>>> -                 mp->pixelformat);
>>>>> -         mp->pixelformat = V4L2_PIX_FMT_YUYV;
>>>>> -         fmt = vivid_get_format(dev, mp->pixelformat);
>>>>> +                 f->pixelformat);
>>>>> +         f->pixelformat = V4L2_PIX_FMT_YUYV;
>>>>> +         fmt = vivid_get_format(dev, f->pixelformat);
>>>>>            }
>>>>>
>>>>> - mp->field = vivid_field_cap(dev, mp->field);
>>>>> + f->field = vivid_field_cap(dev, f->field);
>>>>>            if (vivid_is_webcam(dev)) {
>>>>>                    const struct v4l2_frmsize_discrete *sz =
>>>>>                            v4l2_find_nearest_size(webcam_sizes,
>>>>>                                                   VIVID_WEBCAM_SIZES, width,
>>>>> -                                        height, mp->width, mp->height);
>>>>> +                                        height, f->width, f->height);
>>>>>
>>>>>                    w = sz->width;
>>>>>                    h = sz->height;
>>>>> @@ -604,14 +603,14 @@ int vivid_try_fmt_vid_cap(struct file *file, void *priv,
>>>>>                    w = dev->src_rect.width;
>>>>>                    h = dev->src_rect.height;
>>>>>            }
>>>>> - if (V4L2_FIELD_HAS_T_OR_B(mp->field))
>>>>> + if (V4L2_FIELD_HAS_T_OR_B(f->field))
>>>>>                    factor = 2;
>>>>>            if (vivid_is_webcam(dev) ||
>>>>>                (!dev->has_scaler_cap && !dev->has_crop_cap && !dev->has_compose_cap)) {
>>>>> -         mp->width = w;
>>>>> -         mp->height = h / factor;
>>>>> +         f->width = w;
>>>>> +         f->height = h / factor;
>>>>>            } else {
>>>>> -         struct v4l2_rect r = { 0, 0, mp->width, mp->height * factor };
>>>>> +         struct v4l2_rect r = { 0, 0, f->width, f->height * factor };
>>>>>
>>>>>                    v4l2_rect_set_min_size(&r, &vivid_min_rect);
>>>>>                    v4l2_rect_set_max_size(&r, &vivid_max_rect);
>>>>> @@ -624,16 +623,15 @@ int vivid_try_fmt_vid_cap(struct file *file, void *priv,
>>>>>                    } else if (!dev->has_scaler_cap && !dev->has_crop_cap) {
>>>>>                            v4l2_rect_set_min_size(&r, &dev->src_rect);
>>>>>                    }
>>>>> -         mp->width = r.width;
>>>>> -         mp->height = r.height / factor;
>>>>> +         f->width = r.width;
>>>>> +         f->height = r.height / factor;
>>>>>            }
>>>>>
>>>>>            /* This driver supports custom bytesperline values */
>>>>>
>>>>> - mp->num_planes = fmt->buffers;
>>>>>            for (p = 0; p < fmt->buffers; p++) {
>>>>>                    /* Calculate the minimum supported bytesperline value */
>>>>> -         bytesperline = (mp->width * fmt->bit_depth[p]) >> 3;
>>>>> +         bytesperline = (f->width * fmt->bit_depth[p]) >> 3;
>>>>>                    /* Calculate the maximum supported bytesperline value */
>>>>>                    max_bpl = (MAX_ZOOM * MAX_WIDTH * fmt->bit_depth[p]) >> 3;
>>>>>
>>>>> @@ -642,48 +640,49 @@ int vivid_try_fmt_vid_cap(struct file *file, void *priv,
>>>>>                    if (pfmt[p].bytesperline < bytesperline)
>>>>>                            pfmt[p].bytesperline = bytesperline;
>>>>>
>>>>> -         pfmt[p].sizeimage = (pfmt[p].bytesperline * mp->height) /
>>>>> +         pfmt[p].sizeimage = (pfmt[p].bytesperline * f->height) /
>>>>>                                    fmt->vdownsampling[p] + fmt->data_offset[p];
>>>>> -
>>>>> -         memset(pfmt[p].reserved, 0, sizeof(pfmt[p].reserved));
>>>>>            }
>>>>> +
>>>>> + if (p < VIDEO_MAX_PLANES)
>>>>> +         pfmt[p].sizeimage = 0;
>>>>> +
>>>>>            for (p = fmt->buffers; p < fmt->planes; p++)
>>>>> -         pfmt[0].sizeimage += (pfmt[0].bytesperline * mp->height *
>>>>> +         pfmt[0].sizeimage += (pfmt[0].bytesperline * f->height *
>>>>>                            (fmt->bit_depth[p] / fmt->vdownsampling[p])) /
>>>>>                            (fmt->bit_depth[0] / fmt->vdownsampling[0]);
>>>>>
>>>>> - if (!user_set_csc || !v4l2_is_colorspace_valid(mp->colorspace))
>>>>> -         mp->colorspace = vivid_colorspace_cap(dev);
>>>>> + if (!v4l2_is_colorspace_valid(f->colorspace))
>>>>> +         f->colorspace = vivid_colorspace_cap(dev);
>>>>>
>>>>> - if (!user_set_csc || !v4l2_is_xfer_func_valid(mp->xfer_func))
>>>>> -         mp->xfer_func = vivid_xfer_func_cap(dev);
>>>>> + if (!v4l2_is_xfer_func_valid(f->xfer_func))
>>>>> +         f->xfer_func = vivid_xfer_func_cap(dev);
>>>>>
>>>>>            if (fmt->color_enc == TGP_COLOR_ENC_HSV) {
>>>>> -         if (!user_set_csc || !v4l2_is_hsv_enc_valid(mp->hsv_enc))
>>>>> -                 mp->hsv_enc = vivid_hsv_enc_cap(dev);
>>>>> +         if (!v4l2_is_hsv_enc_valid(f->hsv_enc))
>>>>> +                 f->hsv_enc = vivid_hsv_enc_cap(dev);
>>>>>            } else if (fmt->color_enc == TGP_COLOR_ENC_YCBCR) {
>>>>> -         if (!user_set_csc || !v4l2_is_ycbcr_enc_valid(mp->ycbcr_enc))
>>>>> -                 mp->ycbcr_enc = vivid_ycbcr_enc_cap(dev);
>>>>> +         if (!v4l2_is_ycbcr_enc_valid(f->ycbcr_enc))
>>>>> +                 f->ycbcr_enc = vivid_ycbcr_enc_cap(dev);
>>>>>            } else {
>>>>> -         mp->ycbcr_enc = vivid_ycbcr_enc_cap(dev);
>>>>> +         f->ycbcr_enc = vivid_ycbcr_enc_cap(dev);
>>>>>            }
>>>>>
>>>>>            if (fmt->color_enc == TGP_COLOR_ENC_YCBCR ||
>>>>>                fmt->color_enc == TGP_COLOR_ENC_RGB) {
>>>>> -         if (!user_set_csc || !v4l2_is_quant_valid(mp->quantization))
>>>>> -                 mp->quantization = vivid_quantization_cap(dev);
>>>>> +         if (!v4l2_is_quant_valid(f->quantization))
>>>>> +                 f->quantization = vivid_quantization_cap(dev);
>>>>>            } else {
>>>>> -         mp->quantization = vivid_quantization_cap(dev);
>>>>> +         f->quantization = vivid_quantization_cap(dev);
>>>>>            }
>>>>>
>>>>> - memset(mp->reserved, 0, sizeof(mp->reserved));
>>>>> + memset(f->reserved, 0, sizeof(f->reserved));
>>>>>            return 0;
>>>>>    }
>>>> [snip]
