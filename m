Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61FEF7AA31A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbjIUVrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbjIUVrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:47:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A193610EC
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695317163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Wdj4gmGyib5pMNvMgx8QBu8AD7+XWhaNCUkURKcfP8=;
        b=gMxAAfio1QneeZg+IHbTXg/yaHYVeT7psLPFt41PHWGaZNUJ+AMih/LwI51gzJGN/Dl41v
        oobi5WRKETVv0ISY9IIQK4Dw01UvFmTurOW+KHw0eKaAvh6vJ0xqJ+rXLoWNC6w7EZb67q
        pSsxwU+PHbAtpNudyLvT2J4pAHJWyk4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-0ZGUPsKnPD2QM_dEKXz7gA-1; Thu, 21 Sep 2023 09:07:23 -0400
X-MC-Unique: 0ZGUPsKnPD2QM_dEKXz7gA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9a9cd336c9cso21753066b.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 06:07:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695301642; x=1695906442;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Wdj4gmGyib5pMNvMgx8QBu8AD7+XWhaNCUkURKcfP8=;
        b=i2dqyxokwcGV3U798bUEa+rTXCNy4tQXX74DC8hQPAwrJSmJiUXfrpy1v43F/VvbJ0
         6KTc7xCu4kX/Fo9fiIHN2RvNLcXF32uQ27i9WUuZ02sfQmHlIyW/NGPLh2afArajDOiz
         5EX58rUXFH8aDRiClPdkPxDjYVtYAQd8qA6NuWA4QzEoI1CBiikSMF/WAQszB3RE3g4r
         6zbRWWwEXVtDPmAhVKgZLECKQ4pfJId9ljIZyqbuoKjBVIZqsJ0if4PYZUd6yfOndww7
         35hroYh9cGxwRJ3nn6kI60WYZ6AUXnfqM5znXOCo8dBVbDbc6vjYgnTn7CYHtcJ0KZQp
         klsA==
X-Gm-Message-State: AOJu0Yyoth0CM3Vlrwmi+DHVX/0SPDc4fzbjy3mq7FWjklT8sQ2ks3b1
        2grFOyVS7YxIkFeXqMIlO6O2vf7mBTuokabyZqqYMfXyz0Ka7QdyiNlzfQ/cAhgIcXvH47Xr9qH
        zU252AHC1k19xBVHv66IcksNt
X-Received: by 2002:a17:906:208d:b0:9ae:3ee2:6feb with SMTP id 13-20020a170906208d00b009ae3ee26febmr4648496ejq.2.1695301642755;
        Thu, 21 Sep 2023 06:07:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3W1LmJ2SxmmQZv7FoDBvo0P2UY69D+N3DmcsbEdcSOJH+3jb8tLq0YNrFjbHs9IerRt7Jcg==
X-Received: by 2002:a17:906:208d:b0:9ae:3ee2:6feb with SMTP id 13-20020a170906208d00b009ae3ee26febmr4648483ejq.2.1695301642389;
        Thu, 21 Sep 2023 06:07:22 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-251-4.dyn.eolo.it. [146.241.251.4])
        by smtp.gmail.com with ESMTPSA id rh27-20020a17090720fb00b0099b6becb107sm1030565ejb.95.2023.09.21.06.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 06:07:21 -0700 (PDT)
Message-ID: <b638de8abaa2e468bbcda116368c8e690a461a5d.camel@redhat.com>
Subject: Re: [PATCH net-next] netdev: Remove unneeded semicolon
From:   Paolo Abeni <pabeni@redhat.com>
To:     Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Yang Li <yang.lee@linux.alibaba.com>,
        arkadiusz.kubalewski@intel.com, jiri@resnulli.us
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Date:   Thu, 21 Sep 2023 15:07:20 +0200
In-Reply-To: <0ae9f426-7225-ac4b-4ecd-d53e36dbf365@linux.dev>
References: <20230919010305.120991-1-yang.lee@linux.alibaba.com>
         <0ae9f426-7225-ac4b-4ecd-d53e36dbf365@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-09-20 at 12:10 +0100, Vadim Fedorenko wrote:
> On 19/09/2023 02:03, Yang Li wrote:
> > ./drivers/dpll/dpll_netlink.c:847:3-4: Unneeded semicolon
> >=20
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D6605
> > Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
>=20
> Hi Yang!
> There was a report from Intel's bot too about the issue, could you=20
> please add the tags from it?
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Closes:=20
> https://lore.kernel.org/oe-kbuild-all/202309190540.RFwfIgO7-lkp@intel.com=
/

No need to repost, the pw tools import the above tags automatically.

Cheers,

Paolo

