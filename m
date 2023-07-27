Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D88276445F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 05:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjG0DdM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 26 Jul 2023 23:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjG0DdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 23:33:10 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8634DE75;
        Wed, 26 Jul 2023 20:33:06 -0700 (PDT)
X-UUID: 3cca24fa88994d4ba840e9aac1bc8355-20230727
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:f242e993-158b-4ea5-85f9-ef4642d75f6c,IP:25,
        URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:10
X-CID-INFO: VERSION:1.1.28,REQID:f242e993-158b-4ea5-85f9-ef4642d75f6c,IP:25,UR
        L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:10
X-CID-META: VersionHash:176cd25,CLOUDID:517194a0-0933-4333-8d4f-6c3c53ebd55b,B
        ulkID:230727052327ADIGKCI6,BulkQuantity:4,Recheck:0,SF:19|44|24|17|102,TC:
        nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI
        :0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 3cca24fa88994d4ba840e9aac1bc8355-20230727
X-User: guodongtai@kylinos.cn
Received: from ky [(39.156.73.12)] by mailgw
        (envelope-from <guodongtai@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 455361928; Thu, 27 Jul 2023 11:32:51 +0800
Date:   Thu, 27 Jul 2023 11:32:51 +0800
From:   <guodongtai@kylinos.cn>
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     masahiroy@kernel.org, ndesaulniers@google.com, nathan@kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH] samples/bpf: Update sockex2: get the expected output
 results
Message-ID: <20230727113251.15f538ab@ky>
In-Reply-To: <ZMGOqYG8oCAQmMtq@fjasle.eu>
References: <20230726070955.178288-1-guodongtai@kylinos.cn>
        <ZMGOqYG8oCAQmMtq@fjasle.eu>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2023 23:22:49 +0200
Nicolas Schier <nicolas@fjasle.eu> wrote:

> On Wed, Jul 26, 2023 at 03:09:55PM +0800 George Guo wrote:
> > Running "ping -4 -c5 localhost" only shows 4 times prints not 5:
> > 
> > $ sudo ./samples/bpf/sockex2
> > ip 127.0.0.1 bytes 392 packets 4
> > ip 127.0.0.1 bytes 784 packets 8
> > ip 127.0.0.1 bytes 1176 packets 12
> > ip 127.0.0.1 bytes 1568 packets 16
> > 
> > debug it with num prints:
> > $ sudo ./samples/bpf/sockex2
> > num = 1: ip 127.0.0.1 bytes 392 packets 4
> > num = 2: ip 127.0.0.1 bytes 784 packets 8
> > num = 3: ip 127.0.0.1 bytes 1176 packets 12
> > num = 4: ip 127.0.0.1 bytes 1568 packets 16
> > 
> > The reason is that we check it faster, just put sleep(1) before
> > check while(bpf_map_get_next_key(map_fd, &key, &next_key) == 0).
> > Now we get the expected results:
> > 
> > $ sudo ./samples/bpf/sockex2
> > num = 0: ip 127.0.0.1 bytes 392 packets 4
> > num = 1: ip 127.0.0.1 bytes 784 packets 8
> > num = 2: ip 127.0.0.1 bytes 1176 packets 12
> > num = 3: ip 127.0.0.1 bytes 1568 packets 16
> > num = 4: ip 127.0.0.1 bytes 1960 packets 20
> > 
> > Signed-off-by: George Guo <guodongtai@kylinos.cn>
> > ---  
> 
> Thanks, sounds reasonable to me (but I haven't checked it).  Might
> you want to minimize the diff to only contain the move of the sleep
> call?
> 
> Kind regards,
> Nicolas
> 
> 
> >  samples/bpf/sockex2_user.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> > 
> > diff --git a/samples/bpf/sockex2_user.c b/samples/bpf/sockex2_user.c
> > index 2c18471336f0..84bf1ab77649 100644
> > --- a/samples/bpf/sockex2_user.c
> > +++ b/samples/bpf/sockex2_user.c
> > @@ -18,8 +18,8 @@ int main(int ac, char **argv)
> >  	struct bpf_program *prog;
> >  	struct bpf_object *obj;
> >  	int map_fd, prog_fd;
> > -	char filename[256];
> > -	int i, sock, err;
> > +	char filename[256], command[64];
> > +	int i, sock, err, num = 5;
> >  	FILE *f;
> >  
> >  	snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
> > @@ -42,21 +42,22 @@ int main(int ac, char **argv)
> >  	assert(setsockopt(sock, SOL_SOCKET, SO_ATTACH_BPF,
> > &prog_fd, sizeof(prog_fd)) == 0);
> >  
> > -	f = popen("ping -4 -c5 localhost", "r");
> > +	snprintf(command, sizeof(command), "ping -4 -c%d
> > localhost", num);
> > +	f = popen(command, "r");
> >  	(void) f;
> >  
> > -	for (i = 0; i < 5; i++) {
> > +	for (i = 0; i < num; i++) {
> >  		int key = 0, next_key;
> >  		struct pair value;
> >  
> > +		sleep(1);
> >  		while (bpf_map_get_next_key(map_fd, &key,
> > &next_key) == 0) { bpf_map_lookup_elem(map_fd, &next_key, &value);
> > -			printf("ip %s bytes %lld packets %lld\n",
> > +			printf("num = %d: ip %s bytes %lld packets
> > %lld\n", i, inet_ntoa((struct in_addr){htonl(next_key)}),
> >  			       value.bytes, value.packets);
> >  			key = next_key;
> >  		}
> > -		sleep(1);
> >  	}
> >  	return 0;
> >  }
> > -- 
> > 2.34.1  
> 

hi，

the diff to only contain the move of the sleep call likes this:


diff --git a/samples/bpf/sockex2_user.c b/samples/bpf/sockex2_user.c
index 2c18471336f0..82bb38b9cab0 100644
--- a/samples/bpf/sockex2_user.c
+++ b/samples/bpf/sockex2_user.c
@@ -49,6 +49,7 @@ int main(int ac, char **argv)
                int key = 0, next_key;
                struct pair value;
 
+               sleep(1);
                while (bpf_map_get_next_key(map_fd, &key, &next_key) ==
0) { bpf_map_lookup_elem(map_fd, &next_key, &value);
                        printf("ip %s bytes %lld packets %lld\n",
@@ -56,7 +57,6 @@ int main(int ac, char **argv)
                               value.bytes, value.packets);
                        key = next_key;
                }
-               sleep(1);
        }
        return 0;
 }
