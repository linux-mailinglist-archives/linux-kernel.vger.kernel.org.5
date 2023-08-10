Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB839778153
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbjHJTUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjHJTUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:20:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428FC130
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691695164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iceQwAQJAl69YtgT3tPL7fTEK9peheXin0UtEwIJz4U=;
        b=hZmwnN7f+RDrfyUO6oRlwgzKMTExpV0izh37QlaaNCWbNXDzyICwjd2+B7xa+3mE7lHPwj
        UN3deQZLPoyYla8kUjYj9AA1NSddfSSFz2Dvh47G2uVe2iKMkhmLr0TvHQUg4Fc936yRWR
        k0jUucinL4+tVaOw6Yis4xf9c1oXZC8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-N7AA87OmM42MBlhqTDV8hw-1; Thu, 10 Aug 2023 15:19:23 -0400
X-MC-Unique: N7AA87OmM42MBlhqTDV8hw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-31955c0e2adso254509f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:19:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691695162; x=1692299962;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iceQwAQJAl69YtgT3tPL7fTEK9peheXin0UtEwIJz4U=;
        b=Mte84+1zwxY50Xlyi49BRi2UzODr9koLqHLjYlQciKY+SCjuxouTVCjG/TNf8QVabV
         IEBYY2K8Tv7NZwjx2s1rvO3NWTmqchYBBAcin3cEhWIya4WETOFTbpmXsMBK/JRxmTaE
         5zt9I9rU6jzL9/kwozyxFRHP40qYaGiuaOpVd822sVoKawZoxvNjwabbR8ArQcPdwSPD
         D87/aOOTOXWoIIYZRchxygNDOnZn4KMF1UL66QbGaCYHcukyTTq1Ezn2Xtsmdg7Bee2Y
         T3o0PcA5hixiWC+EGLitBygYO3tkMzExXsA4hXo+9WnTgLZqoouIDHjHEikwMbINAhIN
         dDfA==
X-Gm-Message-State: AOJu0YwisSX6FqJtaV1xkBKP6EA1Sjc/MFJWkZg2YYsAkdjKvCMDvh49
        V8qGrrqn1gZ/I1iggBcJl6D26JwA+VEP92oQ7kzsbdKI9DTWx5CmyvEZG83KcEITUBwoaFGHg3J
        gchNHqLQWtMQKRjd7u38oBMh5
X-Received: by 2002:adf:e5c3:0:b0:314:54f0:df35 with SMTP id a3-20020adfe5c3000000b0031454f0df35mr2635482wrn.16.1691695162057;
        Thu, 10 Aug 2023 12:19:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHz2SgPHeom3N3nUEQAIOwQC+jZPFmkbNwFDaqXXAQqAxgF1D8T52VEBTOiRNUfXExxRDKfTQ==
X-Received: by 2002:adf:e5c3:0:b0:314:54f0:df35 with SMTP id a3-20020adfe5c3000000b0031454f0df35mr2635473wrn.16.1691695161750;
        Thu, 10 Aug 2023 12:19:21 -0700 (PDT)
Received: from redhat.com ([2.55.27.97])
        by smtp.gmail.com with ESMTPSA id b2-20020adfde02000000b0031416362e23sm3022377wrm.3.2023.08.10.12.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 12:19:20 -0700 (PDT)
Date:   Thu, 10 Aug 2023 15:19:17 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Yuan Yao <yuanyaogoog@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Junichi Uekawa <uekawa@chromium.org>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Takaya Saeki <takayas@chromium.org>,
        Keiichi Watanabe <keiichiw@chromium.org>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Tiwei Bie <tiwei.bie@intel.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] virtio_ring: fix avail_wrap_counter in
 virtqueue_add_packed
Message-ID: <20230810151909-mutt-send-email-mst@kernel.org>
References: <20230808083257.3777012-1-yuanyaogoog@chromium.org>
 <CAOJyEHb_KjPawwH+U30iJCDjB-VqH_FR-4qAsUk9T6Sn8FZMBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOJyEHb_KjPawwH+U30iJCDjB-VqH_FR-4qAsUk9T6Sn8FZMBQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 07:05:38PM +0900, Yuan Yao wrote:
> Sorry, but please ignore this thread.

ok, dropped.

