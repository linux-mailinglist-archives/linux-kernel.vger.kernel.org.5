Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758517C4C87
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 10:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345543AbjJKIAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 04:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345393AbjJKIAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 04:00:31 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9B59D
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 01:00:28 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3231dff4343so382363f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 01:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697011226; x=1697616026; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qz8ZijtXypgZfgGaNG42ozEudQwZ/S4uYiYC3qrkT4w=;
        b=InioOG/MLYTDZA2VHIziYLynQlDASgEG+NsTSePgf3hOroOP5kj0NKANmiB5gbdz12
         aIqTEaXK9XQNielWD5T8+sDPokI4KknFTR4RhtYHpUTFyXbbWiNwjL10mDh9FayHngzC
         iJGDxFBD7rnAKMz+WEndq+J7kc7cBGiF5fDYBTf2+oVPrZO15w3ZR5yfLEuDhGzahH8U
         LfhzXgdZtv2kBprW7uywpeluZ/vBjFoqKC1uTHr3QECeMV0y4DLIzLAgUc04sQ9XLjH1
         cz7aU9n/QBmMqNQ0w07ct+mqhcyCzgq6shmHSr2+LjQZth2g0ux3L12ooRYkqFohFRUj
         YgHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697011226; x=1697616026;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qz8ZijtXypgZfgGaNG42ozEudQwZ/S4uYiYC3qrkT4w=;
        b=ebfPlUcGH6LgBqOpwmSfWtNPKlUwAU0OOyVJhqVBqiMqqIXsGOvLqJ8Z+hbzkeKc65
         H2aS+0onyihTP4J/sn6lNNCk2XSztxLa+ARVrjlnm94F7p8HfsM+LUlaW4CinaRUBfnC
         qmevhIQZKCYd6RkvD8UOK/A0YT9F7A2yv+oCfoDkLnM0x+AA5qXwzxWNcGc2PyBPOjhN
         PFx2puNqzBN2z6QKi6XNqzVf2ZbKaJ3Ciw3TCSg8zz0XWAyTbpsZ6nZ4VeaaxkOAfHMs
         eHbKGbSZZ2o7HEypSvVw0vmjCYk71XUK4/LzRq8gh6+hjM4vvpl2HjKkmEy4FjZucD9B
         UEkw==
X-Gm-Message-State: AOJu0YxecCWZvXxRx45/rqdmr2eV0fm9lXCI9S+RulGmFrVJhEddGfeD
        Cr84+nkf9DZ4K0WtNlTxDod/yg==
X-Google-Smtp-Source: AGHT+IFZXX0jarvpNDfAJY2TbuzWh9WTigeX7sMPpWABOvC6Pd2KQOBcSrlU0uwBWQ3W4y5pUCkMbg==
X-Received: by 2002:a05:6000:243:b0:329:6b53:e3ad with SMTP id m3-20020a056000024300b003296b53e3admr12254266wrz.34.1697011226548;
        Wed, 11 Oct 2023 01:00:26 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l9-20020a1c7909000000b00401b242e2e6sm18282714wme.47.2023.10.11.01.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 01:00:26 -0700 (PDT)
Date:   Wed, 11 Oct 2023 11:00:22 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Xiyu Yang <xiyuyang19@fudan.edu.cn>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Xin Tan <tanxin.ctf@gmail.com>, linux-nfs@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH net-XXX] SUNRPC: Add an IS_ERR() check back to where it was
Message-ID: <356fb42c-9cf1-45cd-9233-ac845c507fb7@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This IS_ERR() check was deleted during in a cleanup because, at the time,
the rpcb_call_async() function could not return an error pointer.  That
changed in commit 25cf32ad5dba ("SUNRPC: Handle allocation failure in
rpc_new_task()") and now it can return an error pointer.  Put the check
back.

A related revert was done in commit 13bd90141804 ("Revert "SUNRPC:
Remove unreachable error condition"").

Fixes: 037e910b52b0 ("SUNRPC: Remove unreachable error condition in rpcb_getport_async()")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
It's possible Smatch was responsible for generating the original warning
because it warns for unnecessary NULL checks.  But generally, there was
a future error pointer implied.  Those warnings are just a hint, not a
command.

 net/sunrpc/rpcb_clnt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sunrpc/rpcb_clnt.c b/net/sunrpc/rpcb_clnt.c
index 5988a5c5ff3f..102c3818bc54 100644
--- a/net/sunrpc/rpcb_clnt.c
+++ b/net/sunrpc/rpcb_clnt.c
@@ -769,6 +769,10 @@ void rpcb_getport_async(struct rpc_task *task)
 
 	child = rpcb_call_async(rpcb_clnt, map, proc);
 	rpc_release_client(rpcb_clnt);
+	if (IS_ERR(child)) {
+		/* rpcb_map_release() has freed the arguments */
+		return;
+	}
 
 	xprt->stat.bind_count++;
 	rpc_put_task(child);
-- 
2.39.2

