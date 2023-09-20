Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E5C7A7240
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 07:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbjITFnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 01:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjITFnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 01:43:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573C98F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 22:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695188555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F+ocfh7GT6sPk8Xr1E/8KbVbachV3ZoNZj9eDuM/e9k=;
        b=G+mSyPhx/1/bEQt8gUGfqb8FF1Hp/7ljYPxg/bRJWUOnSlUSyinZHjIHiy0jU7VOjBUb2Q
        +WYHpytldFk6MSfF3oG1fzcD2/Qu9VD5Stf3V+mmXzBPMydowVM5LJKyyEc3GpvSGR1cY7
        HL3Mec2hxaMcwJDxxf8za5kEai6bd/4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-0tdQp5IYOjuiBp1YXj850w-1; Wed, 20 Sep 2023 01:42:34 -0400
X-MC-Unique: 0tdQp5IYOjuiBp1YXj850w-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9a9f282713fso463362266b.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 22:42:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695188553; x=1695793353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F+ocfh7GT6sPk8Xr1E/8KbVbachV3ZoNZj9eDuM/e9k=;
        b=HRPveOdCstGgyu4p9Z8gDzMh56djLnp5nD7iFyQl6em85bVaPbIYTb6wL/89XgcVoW
         mk8yn7DNgrcMcCh1YV/KXsnCYUmXiuV3lHNATrBFx5zd2m9U3bf6tXd3N8amY1MmaGu6
         ZqARIntFHfedzdvdMQ6Fk+xmNcXKwxQ+27Mq0+YuGRpLv+Y4wpaka9XbKTQFvgjSbNbR
         Co3AAY+4Gjjk+InA1dwkWMEQguXfXD3G55FCqyLgu3AgTajhEN+2mthuE/g6B38IUTBa
         WawASHZrc0J4dll82cFUrrPmCUQk++NlLnD6fLxDyiRzJl+GE3YkxLz9jx6yFxBgL85k
         ZX+Q==
X-Gm-Message-State: AOJu0Yyp8xuYmAzJhK3AGy1mLZmGXrIhLuc9UV9HaWbpc7wMtWHf3kwa
        LpKMVmM1cDtruUhLRryR25W0mK0gCmuVyTxTxj0r/++dwhQezYo6P/UnYDkg3bFkxjzKirWMHE7
        RNTaY65p+k6Wz1d5bUlxfBW3kJrP6RXgzfUqLBqOg
X-Received: by 2002:a17:906:3091:b0:99c:c50f:7fb4 with SMTP id 17-20020a170906309100b0099cc50f7fb4mr1108535ejv.1.1695188553007;
        Tue, 19 Sep 2023 22:42:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAT9ZVN8SDeeYMemZ4mFbWTP+nr48rN1jiwughS79T4YtEGAvwyXiDVydiD9hrlBVcBIOBiogvgHmRvOSZMKc=
X-Received: by 2002:a17:906:3091:b0:99c:c50f:7fb4 with SMTP id
 17-20020a170906309100b0099cc50f7fb4mr1108529ejv.1.1695188552793; Tue, 19 Sep
 2023 22:42:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230912082440.325189-1-tglozar@gmail.com> <65036a57ea900_35db10294ec@iweiny-mobl.notmuch>
 <CAP4=nvTKFWHZgrMmfWtRmsjBZ8gijktyJ3rpsNyspqZhL8+Fzg@mail.gmail.com> <6508c1ee9595a_3947ba29473@iweiny-mobl.notmuch>
In-Reply-To: <6508c1ee9595a_3947ba29473@iweiny-mobl.notmuch>
From:   Tomas Glozar <tglozar@redhat.com>
Date:   Wed, 20 Sep 2023 07:42:22 +0200
Message-ID: <CAP4=nvRRTDiZ5ah2Tmawq5traDy1HtS45XWqrxACyG2YXuuDbA@mail.gmail.com>
Subject: Re: [PATCH] nd_btt: Make BTT lanes preemptible
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     =?UTF-8?B?VG9tw6HFoSBHbG96YXI=?= <tglozar@gmail.com>,
        nvdimm@lists.linux.dev, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, dave.jiang@intel.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

po 18. 9. 2023 v 23:32 odes=C3=ADlatel Ira Weiny <ira.weiny@intel.com> naps=
al:
> Thanks for clarifying.  Could you respin the patch with the text below?
> That would have saved me a lot of time digging to see what the code path
> was.

Sent v2 with relevant parts of the BUG message.

