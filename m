Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBD17D96EA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 13:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345771AbjJ0LtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 07:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjJ0LtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 07:49:19 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7D1D7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 04:49:16 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3296b3f03e5so1364338f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 04:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698407354; x=1699012154; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUug1qIw57mr+DRpdd7GliSwdBMty2Oz1w0OdwZh2wo=;
        b=zUbdpQTmv08t5F2FfqV/bUjHd2AENx0tS9j/5G4ZfhQ/F1nsAR4Ilwot8c7fE9h5CG
         tOuo8OxDdL/SyIYXPCqj3y+qWH/o9mGEvIO18MWBmB+ir/WDfLulA2fPt8uCFPORs0ee
         xdEzLiyiApJyeGmTSsHqL4uvUTFzJ7l7ayHrB3TqWPhfW/W0H572XUfz0EER9jMsQjSE
         oP+My/+db2q2pSxQXmw6M6lgEVEcByL5G0XzlEed47c4Phs2CXYgaLHyxth7fLhn6bpb
         1wsL5ufdbfdB640oKaxP6D0w0y3eTIdIi9RTTizTVhnj07p8FA60Hmri6MHecUodGF/G
         7z2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698407354; x=1699012154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZUug1qIw57mr+DRpdd7GliSwdBMty2Oz1w0OdwZh2wo=;
        b=StWUpLOyZDeP+3h7NU9Chr3l3LUtvgMJNDVqIKCXIx5nDvvG5UGYKzHIh81sswO5G5
         /+cx6zLMDkZqy7zDpiTv2RMrj5Kt7udEHJcVWk8LRuZgAZX+OXE9DcS9jPDSEEquLtLk
         6hmxrXs2+MNgoY8EjcuuOav+cOSfXK0Pb9lzI0qABBNTfwhSBYJ5Vaa16NUEDs8UF2OF
         SrEXOlGVR/VAoPEL+pnm4sPe0QxrSvAl4UnkKmj/GMwv6ZtAbTEdS2BlUmOfrTiAlJsP
         QCUxv1KF3unChZ3pubb7q1ac+RGSBtakYHJvnvwlpwFgKe+3IHZLcGi+YCypyey5TizT
         5iEA==
X-Gm-Message-State: AOJu0YyPzS2q4Gc8hUrIgpXQKv+4AXjQ2rsO0EYZ1CwtqChiXjsdnGsg
        Hi/Uf22HL4x3ots9V1neOWNZHg==
X-Google-Smtp-Source: AGHT+IHdHIPlDJMXyZBHvSDTolKHJH+uKVMA1F9BN32sTR8LYz4kzbcC9IvfvgWuJOdhdg8u+hIgwg==
X-Received: by 2002:adf:f14a:0:b0:32d:9f1b:3a1f with SMTP id y10-20020adff14a000000b0032d9f1b3a1fmr1983922wro.31.1698407354572;
        Fri, 27 Oct 2023 04:49:14 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id c13-20020adfe74d000000b0032da49e18fasm1633927wrn.23.2023.10.27.04.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 04:49:14 -0700 (PDT)
Date:   Fri, 27 Oct 2023 14:49:11 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        jlayton@kernel.org, neilb@suse.de, kolga@netapp.com,
        Dai.Ngo@oracle.com, tom@talpey.com,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net v2] net: sunrpc: Fix an off by one in
 rpc_sockaddr2uaddr()
Message-ID: <9a3be793-0d42-4588-8c04-c930671e7ac4@kadam.mountain>
References: <31b27c8e54f131b7eabcbd78573f0b5bfe380d8c.1698184674.git.christophe.jaillet@wanadoo.fr>
 <ZTkmm/clAvIdr+6W@tissot.1015granger.net>
 <20231025092829.6034bfcd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025092829.6034bfcd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 09:28:29AM -0700, Jakub Kicinski wrote:
> On Wed, 25 Oct 2023 10:30:51 -0400 Chuck Lever wrote:
> > Should these two be taken via the NFS client tree or do you intend
> > to include them in some other tree?
> 
> FWIW we're not intending to take these. If only get_maintainer
> understood tree designations :(

I accidentally markedt his NFS patch as net on Oct 11 as well.  :/

https://lore.kernel.org/all/356fb42c-9cf1-45cd-9233-ac845c507fb7@moroto.mountain/

regards,
dan carpenter
