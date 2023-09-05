Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7DB79297B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352176AbjIEQ0d convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 5 Sep 2023 12:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354166AbjIEKA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:00:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3AE1B4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 02:59:37 -0700 (PDT)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-El23khJjNEG83Fcunced4w-1; Tue, 05 Sep 2023 05:59:35 -0400
X-MC-Unique: El23khJjNEG83Fcunced4w-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9a21e030751so28130366b.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 02:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693907974; x=1694512774;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gBZlfxKxk2LlWUUOkePqfSkX4AXTiRxfnDP4dVmsSes=;
        b=FFelbiG2a+DsirrcMNOyqnRLHOIPnL79e/N1egTFYriT17o0qXTW91W9K2e2oyFPRe
         HL2YWaIITxoajwQYn5v+2sCABevZ6GWFahoStBirXB4TLhvPQmPa2Bse8VfS8mUzHabM
         dGnEtK6YBiCK9FzlCAryIN2EM5usmQFRMiTJryiZ1ZuJYgzT3G+WcDDXGm0MJ+yPFb3f
         7jMsH3qYbJ0WUcpLS67lL2VoUdY8AlJyVr+WluPVlaNCC93pakhxA3CNoWhWgDqwD7Yg
         oiYbsH6C7eeAlSPsGWkahXTrGh4fUi2n7FjrE9MXy97L2ipzBGrkbicDrPjqVlwV+0jD
         lYdA==
X-Gm-Message-State: AOJu0YzrAynMmupUblU0RbtZtoU3789Sw2ourq1lX+BmQb3yxcWiOVsv
        ivfUezKXyZVaS0SpIV4ms1cub5qvpa1CTPXIn9pBwtLSJMgnV50Lnb7cxmRLMhRb0K+RQJ5iTbV
        OWsX2/Y6OxJaoNS1WJTnKeOZe
X-Received: by 2002:a17:907:97ce:b0:9a6:5018:9a28 with SMTP id js14-20020a17090797ce00b009a650189a28mr4399996ejc.1.1693907974517;
        Tue, 05 Sep 2023 02:59:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2AD8+Sy5IvG9q1nXmdfGrdgGDhAg33NX/ajK3tvzkl8SJKP2c1kga3FsUVMVmcTRWbw1aaA==
X-Received: by 2002:a17:907:97ce:b0:9a6:5018:9a28 with SMTP id js14-20020a17090797ce00b009a650189a28mr4399980ejc.1.1693907974198;
        Tue, 05 Sep 2023 02:59:34 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-254-194.dyn.eolo.it. [146.241.254.194])
        by smtp.gmail.com with ESMTPSA id a6-20020a170906244600b0099cce6f7d50sm7463220ejb.64.2023.09.05.02.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 02:59:33 -0700 (PDT)
Message-ID: <a88c3486dafcc9e7a8cb5eecf14b6e6b93a13c65.camel@redhat.com>
Subject: Re: [PATCH v2 1/1] xfrm: Use skb_mac_header_was_set() to check for
 MAC header presence
From:   Paolo Abeni <pabeni@redhat.com>
To:     Marcello Sylvester Bauer <email@vger.kernel.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Marcello Sylvester Bauer <sylv@sylv.io>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 05 Sep 2023 11:59:32 +0200
In-Reply-To: <0490137bbc24e95eadf01bed9c31eb1d0a856a21.1693823464.git.sylv@sylv.io>
References: <0490137bbc24e95eadf01bed9c31eb1d0a856a21.1693823464.git.sylv@sylv.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-09-04 at 12:32 +0200, Marcello Sylvester Bauer wrote:
> From: Marcello Sylvester Bauer <sylv@sylv.io>
> 
> Add skb_mac_header_was_set() in xfrm4_remove_tunnel_encap() and
> xfrm6_remove_tunnel_encap() to detect the presence of a MAC header.
> This change prevents a kernel page fault on a non-zero mac_len when the
> mac_header is not set.
> 
> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>

Please include a suitable fixes tag.

Please also include in the commit message the stacktrace:

https://lore.kernel.org/netdev/636d3434-d47a-4cd4-b3ba-7f7254317b64@sylv.io/

trimming the asm code and lines starting with ' ? ' 

I think the real issue could be elsewhere, we should not reach here
with mac_len > 0 && !skb_mac_header_was_set().

Could you please try the following debug patch in your setup, and see
if hints at some other relevant place? 

Thanks,

Paolo

---
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 4174c4b82d13..38ca2c7e50ca 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2793,6 +2793,7 @@ static inline void skb_reset_inner_headers(struct sk_buff *skb)
 
 static inline void skb_reset_mac_len(struct sk_buff *skb)
 {
+	WARN_ON_ONCE(!skb_mac_header_was_set(skb));
 	skb->mac_len = skb->network_header - skb->mac_header;
 }
 

