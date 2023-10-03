Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08667B6697
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 12:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjJCKmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 06:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjJCKmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 06:42:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B76B0
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 03:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696329690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xEM5s9LjMr/YRPee+FNwgiSqc+ylSynZdt7LNsU3DA8=;
        b=DSLIzrKjcWZypmbh1z5xtD0OfVGSU0vrcSXfbrfUQ94MJnRfDv3lkeDdAgfFAbP7/ZN049
        2PQ4uEyQnJJwK8JvkW7HZui81i+ZlSGuGs/pxSkMsNwCvf6zsuuneXmC6WNtS21gDHDpb2
        lhoV/P2CoXwD5t/aXijmM2LBIJrpevA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-L0GLOPf5N-G3JtJhYIrfdA-1; Tue, 03 Oct 2023 06:41:29 -0400
X-MC-Unique: L0GLOPf5N-G3JtJhYIrfdA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9b295d163fdso17512366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 03:41:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696329688; x=1696934488;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xEM5s9LjMr/YRPee+FNwgiSqc+ylSynZdt7LNsU3DA8=;
        b=jqNdsIaufTMkQ5gyRJhgAptJj4l69e6obsdKyuYoVi8DQutcf8wGfBLlM4xG03qYX8
         hhuB0niT0cgOGun5WmrXRo6PVDNnvrhaqhm/Cap+JNc5Eh3SHLWZcRjEL4L3gtqJ7pMo
         IgAUJdInxrGQja7nRVOooo/bTH100i/VbXnk8KNKCtEEjj+gPyd4eHWuombaBQxnumPG
         wBvwJdXsnUY6lKAvG3+OL3uwte5ONpkvrZ6XN3JObPE5+lQCOxD7gRYYaUUFw8Teda0V
         rqrLblY2OyzOynhbzcvQEqgXnuH5+3lm9gooZQvd/1EOtOou6NXEfkd2i7r+v/R5XlNg
         bTpQ==
X-Gm-Message-State: AOJu0YwEi50NowYY07ByP0EYs1LgEm23qQIgIQQqC9lL/+FOvJWeENdj
        lKCbrVlIr3sQUgsXDipUQsbCCJiE+g8B4PQmNoe2oWDLcce/Xy0t3ia9tL8UFpXNqrapd6mr4FM
        mooGsHYZ/gv6jBp+7R6/BoGr9
X-Received: by 2002:a17:906:25d:b0:9b2:bf2d:6b65 with SMTP id 29-20020a170906025d00b009b2bf2d6b65mr13123550ejl.4.1696329688209;
        Tue, 03 Oct 2023 03:41:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTp4Yzu/cOAedVnFfUtha2zEKWPPeZzfa3qsmsNMKsBJ+r6YYEbp9xiJ3pmDMPdNIMRLIP9g==
X-Received: by 2002:a17:906:25d:b0:9b2:bf2d:6b65 with SMTP id 29-20020a170906025d00b009b2bf2d6b65mr13123529ejl.4.1696329687871;
        Tue, 03 Oct 2023 03:41:27 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-232-193.dyn.eolo.it. [146.241.232.193])
        by smtp.gmail.com with ESMTPSA id n10-20020a170906118a00b009a19701e7b5sm832863eja.96.2023.10.03.03.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 03:41:27 -0700 (PDT)
Message-ID: <6e5fb3e148ae1fb4a29561fe9d04235d8be6ab1f.camel@redhat.com>
Subject: Re: [PATCH net-next] net/smc: add support for netdevice in
 containers.
From:   Paolo Abeni <pabeni@redhat.com>
To:     dust.li@linux.alibaba.com,
        Albert Huang <huangjie.albert@bytedance.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>
Cc:     "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        Wen Gu <guwen@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 03 Oct 2023 12:41:25 +0200
In-Reply-To: <20230927034209.GE92403@linux.alibaba.com>
References: <20230925023546.9964-1-huangjie.albert@bytedance.com>
         <20230927034209.GE92403@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-09-27 at 11:42 +0800, Dust Li wrote:
> On Mon, Sep 25, 2023 at 10:35:45AM +0800, Albert Huang wrote:
> > If the netdevice is within a container and communicates externally
> > through network technologies like VXLAN, we won't be able to find
> > routing information in the init_net namespace. To address this issue,
>=20
> Thanks for your founding !
>=20
> I think this is a more generic problem, but not just related to VXLAN ?
> If we use SMC-R v2 and the netdevice is in a net namespace which is not
> init_net, we should always fail, right ? If so, I'd prefer this to be a b=
ugfix.

Re-stating the above to be on the same page: the patch should be re-
posted targeting the net tree, and including a suitable fixes tag.

@Dust Li: please correct me if I misread you.

Thanks,

Paolo

