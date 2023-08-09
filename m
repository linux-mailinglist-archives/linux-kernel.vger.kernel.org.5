Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0957C775E45
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 13:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjHIL4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 07:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjHIL4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 07:56:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F21C10F6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 04:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691582119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zt7LqWIunD9uLiutnGg/r/aysylTVw0JM0XLVqjNXY0=;
        b=WaVAesjaMn0vYFBRyd/4cMxmU8onKb13yo7OL5Ygpdg8k4dPniQDj9zghP57B16BdSCT5Y
        1ixcisOMEmLDMuOOjex1oR6tV6uxb6Y2HE1pNO3CgLfFpnhTnCIp/2tz/fJEn01REGllWE
        b0ajT9197eA9DETjnAxqD4VZaFng37A=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-C6bpNhWZMLqehLwTUcgnkw-1; Wed, 09 Aug 2023 07:55:18 -0400
X-MC-Unique: C6bpNhWZMLqehLwTUcgnkw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30e3ee8a42eso3219840f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 04:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691582117; x=1692186917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zt7LqWIunD9uLiutnGg/r/aysylTVw0JM0XLVqjNXY0=;
        b=g3hR3GmGjvOZNlpm7NSdIkG2/pHEJYE9xILwJYir/qiEMvWQajq4vLwhnWYQIQjV8B
         wi9XLsrpXiTfFsHcd0Qm+0e3pG1AcnIKKmr3d35wwp3vXYxNZKH5RcwlellblFUyveof
         5YpVLQdAqqq+gjI6SAJ6vXpHIb7nxVITLUoZA6+igxhli6kYKKlrjpnEHZpJvvMN9sfU
         bS7pRD57cK8/u3mBBWKLRkfOwDa0T1IZYK5wsnv4ccZVzq5rkmSzBIz39mJ6vjfaweEj
         xiJTxiK0mLaxmeS2R2DxdRun4bbzYwdi7P8igLQ70AZ0mg1SwbtQHePKeOAI05IMmQ9b
         p6Xg==
X-Gm-Message-State: AOJu0Yzi3fgU5FYkG+/XepKQzwZYHQsaiEkghQQkp4icByA3djWn/Bd1
        iCpD6RfT6/u6fmIy5VDImtqbInA4ufkrv2edgCLvA/ckiTxTku7KMIMxfumYHn82gYfuOodK4FT
        +Dokw28rLv6/Wp76K3xd/MGqK
X-Received: by 2002:adf:ea4d:0:b0:314:2ea7:af4a with SMTP id j13-20020adfea4d000000b003142ea7af4amr1808929wrn.13.1691582117236;
        Wed, 09 Aug 2023 04:55:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGr93v0hyLIHcW/k6hETjK36rH1EoKsKnUopp5Llatjqvyl5Un4GPc3urRSOdmONvRVRXAw3g==
X-Received: by 2002:adf:ea4d:0:b0:314:2ea7:af4a with SMTP id j13-20020adfea4d000000b003142ea7af4amr1808911wrn.13.1691582116897;
        Wed, 09 Aug 2023 04:55:16 -0700 (PDT)
Received: from toolbox ([2001:9e8:89b3:0:aff2:5f1a:8020:9f92])
        by smtp.gmail.com with ESMTPSA id r2-20020a5d4942000000b003063a92bbf5sm16596618wrs.70.2023.08.09.04.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 04:55:16 -0700 (PDT)
Date:   Wed, 9 Aug 2023 13:55:15 +0200
From:   Sebastian Wick <sebastian.wick@redhat.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Lyude Paul <lyude@redhat.com>, Aman Dhoot <amandhoot12@gmail.com>,
        Mark Pearson <markpearson@lenovo.com>,
        Raul Rangel <rrangel@chromium.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Andrew Duggan <aduggan@synaptics.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "Input: synaptics - enable InterTouch for the
 ThinkPad P1 G3"
Message-ID: <20230809114242.GA24649@toolbox>
References: <20230808152817.304836-1-sebastian.wick@redhat.com>
 <f13f4ff7d46ecf887ca652b664860c4e07ec8b73.camel@redhat.com>
 <ZNK8aG/y4ol7MXVp@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNK8aG/y4ol7MXVp@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 03:06:32PM -0700, Dmitry Torokhov wrote:
> On Tue, Aug 08, 2023 at 05:49:23PM -0400, Lyude Paul wrote:
> > Hm, This looks fine to me (if not as a final fix, certainly as a workaround)
> > 
> > Reviewed-by: Lyude Paul <lyude@redhat.com>
> > 
> > However, this is definitely something we probably should try to fix at some
> > point - as I imagine this must be happening because something regarding how
> > clicks are reported must have changed again. Andrew, do you have any idea?
> 
> I would like to understand more about this. Is this with newer/older
> BIOS, or another hardware revision of the product, or something else?

All I can say is that the touchpad worked fine before and at some point
it stopped working. I remember updating the system and some firmware
components shortly before this happened but I don't know anymore what
those updates contained.

> Lyude, do you still have access to the unit you originally developed
> the original change for? Is the behavior broken there as well?
> 
> Thanks.
> 
> -- 
> Dmitry
> 

