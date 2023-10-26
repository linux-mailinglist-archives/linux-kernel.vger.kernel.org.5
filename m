Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475D07D8366
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 15:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjJZNSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 09:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjJZNSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 09:18:38 -0400
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90512AB
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 06:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=fRkFsz1VlOEW5rFG9taE2bwY7cLjyhOQP6DO6wVaLOs=; b=jcx72dBMgetqtuU9SWncEF5Fyj
        ZU735Xh9LToJXFg2iX3SW8f6cV74WXtOYHMIzzFea+1/mA1VJvN7n1jmOamiySSV5gyhPv+mgNxm0
        w0FfRCE1sj1aROkiTIMJDOl9rNC3Y4uwoLFDTAQCE2Xm3rNsNUX9SANEf2gf/XdmaWFsnDI7g44go
        hcKpYO5OeALjB0rJU1VU8ciRDMmagb+n08sVgwPPlrrdO20KgpEazICdeWLvhSzjlTr/ydj4MWfwO
        hEDZFqO8idnYCpXV9UXPW9X/eY419U7Hr421oBr/yVWoKTAs/FzHxSMXEArwjmxwPH0iofGtjlnbt
        35sVvZiw7IDT8PBcONxbJftRAbZiwZ13xWizDdZL2ORro11FMmzSSMndxib88AO5tA0A5JQJs6WD6
        6ber8sRTD5s2GAQBIBa2K3ewYiOyB7Ctrp1owZ9XFHusHHzbZ+ellBD0/6sbz91eJyrLl/vxcApzO
        +kBON3gVKBbi0eOgs6gJHo6H1U8Hz+XWEe/CH831F4tNHg4j6llotxOo4HZLqIGbZFLaihZKC18fh
        y9q67KEHqNxbxaD0Qxgr/Nl8NTexgpQUpvMGdt5goebm0MRzZRmq9xLF7YkyYfUGraxHzrLuS7q4l
        hbCoUDWQTp75bDwsqqHvQ/9l7sdiiC2krgkwtIz/k=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     Hangyu Hua <hbh25y@gmail.com>, asmadeus@codewreck.org
Cc:     ericvh@kernel.org, lucho@ionkov.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        jvrao@linux.vnet.ibm.com, v9fs@lists.linux.dev,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: 9p: fix possible memory leak in p9_check_errors()
Date:   Thu, 26 Oct 2023 15:18:16 +0200
Message-ID: <2383398.41Bra3A7bo@silver>
In-Reply-To: <ZTpTU8-1zn_P22QX@codewreck.org>
References: <20231026092351.30572-1-hbh25y@gmail.com> <ZTpTU8-1zn_P22QX@codewreck.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, October 26, 2023 1:53:55 PM CEST asmadeus@codewreck.org wrote:
> 
> Hangyu Hua wrote on Thu, Oct 26, 2023 at 05:23:51PM +0800:
> > When p9pdu_readf is called with "s?d" attribute, it allocates a pointer
> > that will store a string. But when p9pdu_readf() fails while handling "d"
> > then this pointer will not be freed in p9_check_errors.
> 
> Right, that sounds correct to me.
> 
> Out of curiosity how did you notice this? The leak shouldn't happen with
> any valid server.
> 
> This cannot break anything so I'll push this to -next tomorrow and
> submit to Linus next week
> 
> > Fixes: ca41bb3e21d7 ("[net/9p] Handle Zero Copy TREAD/RERROR case in !dotl case.")
> 
> This commit moves this code a bit, but the p9pdu_readf call predates
> it -- in this case the Fixes tag is probably not useful; this affects
> all maintained kernels.

Looks like it exists since introduction of p9_check_errors(), therefore:

Fixes: 51a87c552dfd ("9p: rework client code to use new protocol support functions")

> > Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> > ---
> >  net/9p/client.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/9p/client.c b/net/9p/client.c
> > index 86bbc7147fc1..6c7cd765b714 100644
> > --- a/net/9p/client.c
> > +++ b/net/9p/client.c
> > @@ -540,12 +540,15 @@ static int p9_check_errors(struct p9_client *c, struct p9_req_t *req)
> >  		return 0;
> >  
> >  	if (!p9_is_proto_dotl(c)) {
> > -		char *ename;
> > +		char *ename = NULL;
> >  
> >  		err = p9pdu_readf(&req->rc, c->proto_version, "s?d",
> >  				  &ename, &ecode);
> > -		if (err)
> > +		if (err) {
> > +			if (ename != NULL)
> > +				kfree(ename);
> 
> Don't check for NULL before kfree - kfree does it.
> If that's the only remark you get I can fix it when applying the commit
> on my side.

With those two remarks addressed:

Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>

> 
> 
> >  			goto out_err;
> > +		}
> >  
> >  		if (p9_is_proto_dotu(c) && ecode < 512)
> >  			err = -ecode;
> 
> 


