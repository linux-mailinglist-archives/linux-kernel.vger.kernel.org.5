Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC152791581
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 12:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243886AbjIDKJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 06:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbjIDKJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 06:09:06 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3A919B;
        Mon,  4 Sep 2023 03:09:02 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4RfPVc2pFzz9sZW;
        Mon,  4 Sep 2023 12:08:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1693822136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O9zv3iqZXhzSiaPFJFDo6Yol9h8OZ0K8HA2F58iIyUU=;
        b=plCCj/rMTrMc752Dz3n1sOClpJEeNy7m1n2hPuv9YAoqF5oLoBq2iEgF+/fGNftxTbiM6p
        TCf+vu3mZ4h+BkPbc+Ur9UyC25x2aX65Eop0PrLf6+N/nSaIF6y49K012/XsdOGi8cjPXN
        tsLTSoCZ1VVFwv3KqYRjcyTSo+X5wwb4MK92ITfeWhmAsGo1OnL+D8VC/bk60hG1L+0Og7
        FeTB4PWbjVyav3yUts0METVQJJwbLcWDLxYqgKF8Gt8owun9DdVe+KZwWpkSEB7qCELzn4
        Y4xJhoHmH0/UGMLH9lfJ1xEjiv7A+NHA35qV6NPzo+mcekN0MVP4nFxXFGo3QQ==
Content-Type: multipart/mixed; boundary="------------lVALqjZO6U5LtfkSh57OjJNa"
Message-ID: <636d3434-d47a-4cd4-b3ba-7f7254317b64@sylv.io>
Date:   Mon, 4 Sep 2023 12:08:52 +0200
MIME-Version: 1.0
Content-Language: en-US, de-DE
To:     Eyal Birger <eyal.birger@gmail.com>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <acb58c1adc02d0b949d8371933b2afe3c056c33f.1693583786.git.sylv@sylv.io>
 <CAHsH6Gv7m2Q=3sPZsRSMfqasay0P7j9zZT=DDwwgv7TuPX5agg@mail.gmail.com>
From:   Marcello Sylverster Bauer <sylv@sylv.io>
Subject: Re: [PATCH v1 1/1] xfrm: Use skb_mac_header_was_set() to check for
 MAC header presence
In-Reply-To: <CAHsH6Gv7m2Q=3sPZsRSMfqasay0P7j9zZT=DDwwgv7TuPX5agg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------lVALqjZO6U5LtfkSh57OjJNa
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Eval,

On 9/2/23 20:39, Eyal Birger wrote:
> Hi Marcello,
> 
> On Fri, Sep 1, 2023 at 7:15 PM Marcello Sylvester Bauer
> <email@web.codeaurora.org> wrote:
>>
>> From: Marcello Sylvester Bauer <sylv@sylv.io>
>>
>> Replace skb->mac_len with skb_mac_header_was_set() in
>> xfrm4_remove_tunnel_encap() and xfrm6_remove_tunnel_encap() to detect
>> the presence of a MAC header. This change prevents a kernel page fault
>> that could occur when a MAC address is added to an L3 interface using
>> xfrm.
>>
>> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
>> ---
>>   net/xfrm/xfrm_input.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
>> index d5ee96789d4b..afa1f1052065 100644
>> --- a/net/xfrm/xfrm_input.c
>> +++ b/net/xfrm/xfrm_input.c
>> @@ -250,7 +250,7 @@ static int xfrm4_remove_tunnel_encap(struct xfrm_state *x, struct sk_buff *skb)
>>
>>          skb_reset_network_header(skb);
>>          skb_mac_header_rebuild(skb);
>> -       if (skb->mac_len)
>> +       if (skb_mac_header_was_set(skb))
>>                  eth_hdr(skb)->h_proto = skb->protocol;
>>
>>          err = 0;
>> @@ -287,7 +287,7 @@ static int xfrm6_remove_tunnel_encap(struct xfrm_state *x, struct sk_buff *skb)
>>
>>          skb_reset_network_header(skb);
>>          skb_mac_header_rebuild(skb);
>> -       if (skb->mac_len)
>> +       if (skb_mac_header_was_set(skb))
>>                  eth_hdr(skb)->h_proto = skb->protocol;
> 
> I checked xfrm tunnels over both GRE and IPIP, and in both cases when reaching
> this code the skb->mac_len was 0, whereas skb_mac_header_was_set()
> was 1.
> 
> So in both cases this suggested patch would make this condition true and
> write to an Ethernet header location on these L3 devices.

Oh, so my first guess was right and we need to check for both.

We were able to get socket buffers where the mac_len was non-zero, but 
the mac_header was not set. Not sure if this is a bug from somewhere 
else, but this causes an "unable to handle page fault for address XXX" 
error.

I have attached a decoded crash log to this email using kernel version 
6.1.38.

As you can see, the line net/xfrm/xfrm_input.c:290, which contains the 
following, causes the error:
```
eth_hdr(skb)->h_proto = skb->protocol;
```

IIUC RAX contains mac_header and is set to 0xffff, meaning it is not 
set. This causes skb_mac_header to reference a wrong address for the 
header, resulting in the page fault.

> 
> Can you please share your reproduction scenario for this case?

We have a special setup where a WWAN interface is forwarded to a QEMU VM 
as a virtual network interface. Here is the relevant information based 
on the internal bug report that addresses this issue:

---

Kernel version: 6.1.38

Problem occurs with quectel em120r-gl and Intel 5000 5G modems.
Both modems do not support bridge mode, i.e. no L2 but only L3 ipraw 
communication. Specifically, the interface has no MAC address.

Our application uses by default the MAC address of the physical adapter 
for the virtual adapter, so e.g. host entries in dnsmasq are created in 
the direction of windows VM.

Modify net_hotplug in udev: Assign fake MAC address to wwan interface 
(actually writes only the MAC to a file, which is passed to the VM as 
MAC in the hotplug case)

# mac address required for hotplug -> end
#ATTRS{address}=="", GOTO="tvpnc_network_end"

ACTION=="add", ATTRS{address}=="", \
     NAME=="en*|wl*|ww*", \
     RUN+="/usr/share/scripts/net_hotplug.sh -a -i $name -m 
aa:bb:cc:dd:ee:ff"

ACTION=="add", ATTRS{address}!="", \
     NAME=="en*|wl*|ww*", \
     RUN+="/usr/share/scripts/net_hotplug.sh -a -i $name -m $attr{address}"

When Windows establishes a cellular connection and connects to a 
strongSwan VPN, the host Linux kernel crashes and immediately restarts.

---

The custom QEMU hotplug script net_hotplug.sh, which adds the virtual 
network interface to the running VM and binds it to the VM using the 
real or the "fake" Mac address.

I got feedback that adding "skb_mac_header_was_set(skb)" to the 
condition fixed the problem.

The 2nd version of this patch will check for both bot, mac_len and if 
the header was set.

Thanks
Marcello

> 
> Thanks,
> Eyal.
> 
>>
>>          err = 0;
>> --
>> 2.42.0
>>
>>
--------------lVALqjZO6U5LtfkSh57OjJNa
Content-Type: text/x-log; charset=UTF-8; name="decoded_crash.log"
Content-Disposition: attachment; filename="decoded_crash.log"
Content-Transfer-Encoding: base64

WyAxMDA4LjY2NjgxN10gQlVHOiB1bmFibGUgdG8gaGFuZGxlIHBhZ2UgZmF1bHQgZm9yIGFk
ZHJlc3M6IGZmZmY4ODgxMDFiZTc5NGIKWyAxMDA4LjY2NzQ2OV0gI1BGOiBzdXBlcnZpc29y
IHdyaXRlIGFjY2VzcyBpbiBrZXJuZWwgbW9kZQpbIDEwMDguNjY4MjAwXSAjUEY6IGVycm9y
X2NvZGUoMHgwMDAzKSAtIHBlcm1pc3Npb25zIHZpb2xhdGlvbgpbIDEwMDguNjY4OTM5XSBQ
R0QgMjgwMTA2NyBQNEQgMjgwMTA2NyBQVUQgMTA2YTEzMDYzIFBNRCAxMDNlOGYwNjMgUFRF
IDgwMDAwMDAxMDFiZTcwNjEKWyAxMDA4LjY2OTY5N10gT29wczogMDAwMyBbIzFdIFBSRUVN
UFQgU01QIE5PUFRJClsgMTAwOC42NzA0MzVdIENQVTogMyBQSUQ6IDAgQ29tbTogc3dhcHBl
ci8zIEtkdW1wOiBsb2FkZWQgTm90IHRhaW50ZWQgNi4xLjM4ICMxClsgMTAwOC42NzExOTNd
IEhhcmR3YXJlIG5hbWU6IExFTk9WTyAyMFdNMDBBN0dFLzIwV00wMEE3R0UsIEJJT1MgTjM1
RVQ1MFcgKDEuNTAgKSAwOS8xNS8yMDIyClsgMTAwOC42NzE5OTBdIFJJUDogMDAxMDp4ZnJt
X2lucHV0IChuZXQveGZybS94ZnJtX2lucHV0LmM6MjkwIG5ldC94ZnJtL3hmcm1faW5wdXQu
YzozNDkgbmV0L3hmcm0veGZybV9pbnB1dC5jOjM5MSBuZXQveGZybS94ZnJtX2lucHV0LmM6
NDQzIG5ldC94ZnJtL3hmcm1faW5wdXQuYzo2ODkpIApbIDEwMDguNjcyODcyXSBDb2RlOiA4
ZCAwYiAwMCA2NiA0MSA4MyA3YyAyNCA3OCAwMCAwZiA4NCA1ZCBmYSBmZiBmZiA0MSAwZiBi
NyA4YyAyNCBiMCAwMCAwMCAwMCA0MSAwZiBiNyA4NCAyNCBiNiAwMCAwMCAwMCA0OSA4YiA5
NCAyNCBjMCAwMCAwMCAwMCA8NjY+IDg5IDRjIDAyIDBjIGU5IDM5IGZhIGZmIGZmIDQxIGI4
IDA4IDAwIDAwIDAwIDY2IDQ1IDg5IDg0IDI0IGIwCkFsbCBjb2RlCj09PT09PT09CiAgIDA6
CThkIDBiICAgICAgICAgICAgICAgIAlsZWEgICAgKCVyYngpLCVlY3gKICAgMjoJMDAgNjYg
NDEgICAgICAgICAgICAgCWFkZCAgICAlYWgsMHg0MSglcnNpKQogICA1Ogk4MyA3YyAyNCA3
OCAwMCAgICAgICAJY21wbCAgICQweDAsMHg3OCglcnNwKQogICBhOgkwZiA4NCA1ZCBmYSBm
ZiBmZiAgICAJamUgICAgIDB4ZmZmZmZmZmZmZmZmZmE2ZAogIDEwOgk0MSAwZiBiNyA4YyAy
NCBiMCAwMCAJbW92endsIDB4YjAoJXIxMiksJWVjeAogIDE3OgkwMCAwMCAKICAxOToJNDEg
MGYgYjcgODQgMjQgYjYgMDAgCW1vdnp3bCAweGI2KCVyMTIpLCVlYXgKICAyMDoJMDAgMDAg
CiAgMjI6CTQ5IDhiIDk0IDI0IGMwIDAwIDAwIAltb3YgICAgMHhjMCglcjEyKSwlcmR4CiAg
Mjk6CTAwIAogIDJhOioJNjYgODkgNGMgMDIgMGMgICAgICAgCW1vdiAgICAlY3gsMHhjKCVy
ZHgsJXJheCwxKQkJPC0tIHRyYXBwaW5nIGluc3RydWN0aW9uCiAgMmY6CWU5IDM5IGZhIGZm
IGZmICAgICAgIAlqbXAgICAgMHhmZmZmZmZmZmZmZmZmYTZkCiAgMzQ6CTQxIGI4IDA4IDAw
IDAwIDAwICAgIAltb3YgICAgJDB4OCwlcjhkCiAgM2E6CTY2ICAgICAgICAgICAgICAgICAg
IAlkYXRhMTYKICAzYjoJNDUgICAgICAgICAgICAgICAgICAgCXJleC5SQgogIDNjOgk4OSAg
ICAgICAgICAgICAgICAgICAJLmJ5dGUgMHg4OQogIDNkOgk4NCAyNCBiMCAgICAgICAgICAg
ICAJdGVzdCAgICVhaCwoJXJheCwlcnNpLDQpCgpDb2RlIHN0YXJ0aW5nIHdpdGggdGhlIGZh
dWx0aW5nIGluc3RydWN0aW9uCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT0KICAgMDoJNjYgODkgNGMgMDIgMGMgICAgICAgCW1vdiAgICAlY3gsMHhjKCVy
ZHgsJXJheCwxKQogICA1OgllOSAzOSBmYSBmZiBmZiAgICAgICAJam1wICAgIDB4ZmZmZmZm
ZmZmZmZmZmE0MwogICBhOgk0MSBiOCAwOCAwMCAwMCAwMCAgICAJbW92ICAgICQweDgsJXI4
ZAogIDEwOgk2NiAgICAgICAgICAgICAgICAgICAJZGF0YTE2CiAgMTE6CTQ1ICAgICAgICAg
ICAgICAgICAgIAlyZXguUkIKICAxMjoJODkgICAgICAgICAgICAgICAgICAgCS5ieXRlIDB4
ODkKICAxMzoJODQgMjQgYjAgICAgICAgICAgICAgCXRlc3QgICAlYWgsKCVyYXgsJXJzaSw0
KQpbIDEwMDguNjczODE1XSBSU1A6IDAwMTg6ZmZmZmM5MDAwMDFlNGIyOCBFRkxBR1M6IDAw
MDEwMjA2ClsgMTAwOC42NzQ3NTRdIFJBWDogMDAwMDAwMDAwMDAwZmZmZiBSQlg6IGZmZmY4
ODgxMTk1NWRhNTEgUkNYOiAwMDAwMDAwMDAwMDAwMDA4ClsgMTAwOC42NzU3NTFdIFJEWDog
ZmZmZjg4ODEwMWJkNzk0MCBSU0k6IDAwMDAwMDAwMDAwMDAwMDQgUkRJOiAwMDAwMDAwMDAw
MDAwMDA0ClsgMTAwOC42NzY5MzldIFJCUDogZmZmZmM5MDAwMDFlNGI5MCBSMDg6IDAwMDAw
MDAwMDAwMDAwNDEgUjA5OiAwMDAwMDAwMDAwMDAwMDAwClsgMTAwOC42Nzc5MDBdIFIxMDog
MDAwMDAwMDAwMDAwMDA4MCBSMTE6IDAwMDAwMDAwMDAwMDAwMDAgUjEyOiBmZmZmODg4MTE5
NTVkYTAwClsgMTAwOC42Nzg4ODVdIFIxMzogMDAwMDAwMDAwMDAwMDAwMiBSMTQ6IDAwMDAw
MDAwMDAwMDAwMDAgUjE1OiBmZmZmODg4MTFmNzkzNjAwClsgMTAwOC42Nzk3MDNdIEZTOiAg
MDAwMDAwMDAwMDAwMDAwMCgwMDAwKSBHUzpmZmZmODg4MjU3NmMwMDAwKDAwMDApIGtubEdT
OjAwMDAwMDAwMDAwMDAwMDAKWyAxMDA4LjY4MDQ5N10gQ1M6ICAwMDEwIERTOiAwMDAwIEVT
OiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMwpbIDEwMDguNjgxMzAzXSBDUjI6IGZmZmY4
ODgxMDFiZTc5NGIgQ1IzOiAwMDAwMDAwMDAyNDBhMDAzIENSNDogMDAwMDAwMDAwMDc3MmVh
MApbIDEwMDguNjgyMTA5XSBQS1JVOiA1NTU1NTU1NApbIDEwMDguNjgyOTI3XSBDYWxsIFRy
YWNlOgpbIDEwMDguNjgzNzcyXSAgPElSUT4KWyAxMDA4LjY4NDY2MV0gPyBzaG93X3JlZ3Mu
cGFydC4wIChhcmNoL3g4Ni9rZXJuZWwvZHVtcHN0YWNrLmM6NDc5KSAKWyAxMDA4LjY4NTUz
N10gPyBfX2RpZSAoYXJjaC94ODYva2VybmVsL2R1bXBzdGFjay5jOjQyMSBhcmNoL3g4Ni9r
ZXJuZWwvZHVtcHN0YWNrLmM6NDM0KSAKWyAxMDA4LjY4NjM2Nl0gPyBwYWdlX2ZhdWx0X29v
cHMgKGFyY2gveDg2L21tL2ZhdWx0LmM6NzI3KSAKWyAxMDA4LjY4NzIwN10gPyBrZXJuZWxt
b2RlX2ZpeHVwX29yX29vcHMgKGFyY2gveDg2L21tL2ZhdWx0LmM6NzgyKSAKWyAxMDA4LjY4
ODA1MF0gPyBfX2JhZF9hcmVhX25vc2VtYXBob3JlIChhcmNoL3g4Ni9tbS9mYXVsdC5jOjg4
MCkgClsgMTAwOC42ODg4NjhdID8gYmFkX2FyZWFfbm9zZW1hcGhvcmUgKGFyY2gveDg2L21t
L2ZhdWx0LmM6ODg3KSAKWyAxMDA4LjY4OTY5Nl0gPyBleGNfcGFnZV9mYXVsdCAoYXJjaC94
ODYvbW0vZmF1bHQuYzoxMjMyIGFyY2gveDg2L21tL2ZhdWx0LmM6MTQ2OSBhcmNoL3g4Ni9t
bS9mYXVsdC5jOjE1MjcpIApbIDEwMDguNjkwNTExXSA/IHNrYl9jb3B5X2JpdHMgKG5ldC9j
b3JlL3NrYnVmZi5jOjI1MzEpIApbIDEwMDguNjkxMzE1XSA/IGFzbV9leGNfcGFnZV9mYXVs
dCAoLi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9pZHRlbnRyeS5oOjU3MCkgClsgMTAwOC42OTIy
MzJdID8geGZybV9pbnB1dCAobmV0L3hmcm0veGZybV9pbnB1dC5jOjI5MCBuZXQveGZybS94
ZnJtX2lucHV0LmM6MzQ5IG5ldC94ZnJtL3hmcm1faW5wdXQuYzozOTEgbmV0L3hmcm0veGZy
bV9pbnB1dC5jOjQ0MyBuZXQveGZybS94ZnJtX2lucHV0LmM6Njg5KSAKWyAxMDA4LjY5MzAz
OV0gPyB4ZnJtX2lucHV0IChuZXQveGZybS94ZnJtX2lucHV0LmM6Njc3KSAKWyAxMDA4LjY5
MzkyMV0geGZybWlfaW5wdXQgKG5ldC94ZnJtL3hmcm1faW50ZXJmYWNlX2NvcmUuYzozMzYp
IApbIDEwMDguNjk0OTgxXSB4ZnJtaTRfaW5wdXQgKG5ldC94ZnJtL3hmcm1faW50ZXJmYWNl
X2NvcmUuYzozNTIpIApbIDEwMDguNjk1Nzc5XSB4ZnJtNF9yY3ZfZW5jYXAgKG5ldC9pcHY0
L3hmcm00X3Byb3RvY29sLmM6ODQpIApbIDEwMDguNjk2NTAyXSB4ZnJtNF91ZHBfZW5jYXBf
cmN2IChuZXQvaXB2NC94ZnJtNF9pbnB1dC5jOjE2MSkgClsgMTAwOC42OTcxMjddID8geGZy
bTRfcmN2IChuZXQvaXB2NC94ZnJtNF9pbnB1dC5jOjgzKSAKWyAxMDA4LjY5Nzc2NV0gdWRw
X3F1ZXVlX3Jjdl9vbmVfc2tiIChuZXQvaXB2NC91ZHAuYzoyMTU0KSAKWyAxMDA4LjY5ODM5
N10gdWRwX3F1ZXVlX3Jjdl9za2IgKG5ldC9pcHY0L3VkcC5jOjIyNDUpIApbIDEwMDguNjk5
MDIxXSB1ZHBfdW5pY2FzdF9yY3Zfc2tiIChuZXQvaXB2NC91ZHAuYzoyMzk5IChkaXNjcmlt
aW5hdG9yIDMpKSAKWyAxMDA4LjY5OTY1N10gX191ZHA0X2xpYl9yY3YgKG5ldC9pcHY0L3Vk
cC5jOjI0NjMpIApbIDEwMDguNzAwMjQyXSA/IGlwdF9kb190YWJsZSAobmV0L2lwdjQvbmV0
ZmlsdGVyL2lwX3RhYmxlcy5jOjM2MikgClsgMTAwOC43MDA3OTJdID8gcmF3X2xvY2FsX2Rl
bGl2ZXIgKG5ldC9pcHY0L3Jhdy5jOjE5OSkgClsgMTAwOC43MDEzNzFdIHVkcF9yY3YgKG5l
dC9pcHY0L3VkcC5jOjI2NDQpIApbIDEwMDguNzAxOTgxXSBpcF9wcm90b2NvbF9kZWxpdmVy
X3JjdSAobmV0L2lwdjQvaXBfaW5wdXQuYzoyMDUgKGRpc2NyaW1pbmF0b3IgNCkpIApbIDEw
MDguNzAyNTkxXSBpcF9sb2NhbF9kZWxpdmVyX2ZpbmlzaCAoLi9pbmNsdWRlL2xpbnV4L3Jj
dXBkYXRlLmg6Nzc5IG5ldC9pcHY0L2lwX2lucHV0LmM6MjM0KSAKWyAxMDA4LjcwMzIwMl0g
aXBfbG9jYWxfZGVsaXZlciAoLi9pbmNsdWRlL2xpbnV4L25ldGZpbHRlci5oOjMwMiAuL2lu
Y2x1ZGUvbGludXgvbmV0ZmlsdGVyLmg6Mjk2IG5ldC9pcHY0L2lwX2lucHV0LmM6MjU0KSAK
WyAxMDA4LjcwMzgyNF0gPyBpcF9wcm90b2NvbF9kZWxpdmVyX3JjdSAobmV0L2lwdjQvaXBf
aW5wdXQuYzoyMjgpIApbIDEwMDguNzA0NDQwXSBpcF9yY3YgKC4vaW5jbHVkZS9uZXQvZHN0
Lmg6NDU0IG5ldC9pcHY0L2lwX2lucHV0LmM6NDQ5IC4vaW5jbHVkZS9saW51eC9uZXRmaWx0
ZXIuaDozMDIgLi9pbmNsdWRlL2xpbnV4L25ldGZpbHRlci5oOjI5NiBuZXQvaXB2NC9pcF9p
bnB1dC5jOjU2OSkgClsgMTAwOC43MDUwNTldID8gaXBfc3VibGlzdF9yY3YgKG5ldC9pcHY0
L2lwX2lucHV0LmM6NDM2KSAKWyAxMDA4LjcwNTY2Nl0gX19uZXRpZl9yZWNlaXZlX3NrYl9v
bmVfY29yZSAobmV0L2NvcmUvZGV2LmM6NTQ5NiAoZGlzY3JpbWluYXRvciA0KSkgClsgMTAw
OC43MDYyNzFdIHByb2Nlc3NfYmFja2xvZyAoLi9pbmNsdWRlL2xpbnV4L3JjdXBkYXRlLmg6
Nzc5IG5ldC9jb3JlL2Rldi5jOjU5MzkpIApbIDEwMDguNzA2ODg2XSA/IF9yYXdfcmVhZF91
bmxvY2tfYmggKGtlcm5lbC9sb2NraW5nL3NwaW5sb2NrLmM6Mjg1KSAKWyAxMDA4LjcwNzQ2
M10gX19uYXBpX3BvbGwgKG5ldC9jb3JlL2Rldi5jOjY1MDUpIApbIDEwMDguNzA4MDI0XSBu
ZXRfcnhfYWN0aW9uIChuZXQvY29yZS9kZXYuYzo2NTc0IG5ldC9jb3JlL2Rldi5jOjY2ODMp
IApbIDEwMDguNzA4NjU4XSBfX2RvX3NvZnRpcnEgKGtlcm5lbC9zb2Z0aXJxLmM6NTcxKSAK
WyAxMDA4LjcwOTIxNF0gaXJxX2V4aXRfcmN1IChrZXJuZWwvc29mdGlycS5jOjQ0NSBrZXJu
ZWwvc29mdGlycS5jOjY1MCBrZXJuZWwvc29mdGlycS5jOjY2MikgClsgMTAwOC43MDk3NjRd
IGNvbW1vbl9pbnRlcnJ1cHQgKGFyY2gveDg2L2tlcm5lbC9pcnEuYzoyNDAgKGRpc2NyaW1p
bmF0b3IgMTQpKSAKWyAxMDA4LjcxMDMyM10gIDwvSVJRPgpbIDEwMDguNzEwODU5XSAgPFRB
U0s+ClsgMTAwOC43MTEzOTNdIGFzbV9jb21tb25faW50ZXJydXB0ICguL2FyY2gveDg2L2lu
Y2x1ZGUvYXNtL2lkdGVudHJ5Lmg6NjQwKSAKWyAxMDA4LjcxMTkyN10gUklQOiAwMDEwOmNw
dWlkbGVfZW50ZXJfc3RhdGUgKGRyaXZlcnMvY3B1aWRsZS9jcHVpZGxlLmM6MjYxKSAKWyAx
MDA4LjcxMjQ3MV0gQ29kZTogZjggN2MgOWQgZmYgMzEgZmYgNDkgODkgYzcgZTggYmUgMTQg
OWQgZmYgODAgN2QgZDcgMDAgNzQgMTIgOWMgNTggZjYgYzQgMDIgMGYgODUgYzcgMDEgMDAg
MDAgMzEgZmYgZTggYzYgOGUgYTEgZmYgZmIgNDUgODUgZjYgPDBmPiA4OCBjOSAwMCAwMCAw
MCA0OSA2MyBjZSA0YyA4OSBmYSA0OCAyYiA1NSBjOCA0OCA2YiBmMSA2OCA0OCA4ZApBbGwg
Y29kZQo9PT09PT09PQogICAwOglmOCAgICAgICAgICAgICAgICAgICAJY2xjCiAgIDE6CTdj
IDlkICAgICAgICAgICAgICAgIAlqbCAgICAgMHhmZmZmZmZmZmZmZmZmZmEwCiAgIDM6CWZm
IDMxICAgICAgICAgICAgICAgIAlwdXNoICAgKCVyY3gpCiAgIDU6CWZmIDQ5IDg5ICAgICAg
ICAgICAgIAlkZWNsICAgLTB4NzcoJXJjeCkKICAgODoJYzcgICAgICAgICAgICAgICAgICAg
CShiYWQpCiAgIDk6CWU4IGJlIDE0IDlkIGZmICAgICAgIAljYWxsICAgMHhmZmZmZmZmZmZm
OWQxNGNjCiAgIGU6CTgwIDdkIGQ3IDAwICAgICAgICAgIAljbXBiICAgJDB4MCwtMHgyOSgl
cmJwKQogIDEyOgk3NCAxMiAgICAgICAgICAgICAgICAJamUgICAgIDB4MjYKICAxNDoJOWMg
ICAgICAgICAgICAgICAgICAgCXB1c2hmCiAgMTU6CTU4ICAgICAgICAgICAgICAgICAgIAlw
b3AgICAgJXJheAogIDE2OglmNiBjNCAwMiAgICAgICAgICAgICAJdGVzdCAgICQweDIsJWFo
CiAgMTk6CTBmIDg1IGM3IDAxIDAwIDAwICAgIAlqbmUgICAgMHgxZTYKICAxZjoJMzEgZmYg
ICAgICAgICAgICAgICAgCXhvciAgICAlZWRpLCVlZGkKICAyMToJZTggYzYgOGUgYTEgZmYg
ICAgICAgCWNhbGwgICAweGZmZmZmZmZmZmZhMThlZWMKICAyNjoJZmIgICAgICAgICAgICAg
ICAgICAgCXN0aQogIDI3Ogk0NSA4NSBmNiAgICAgICAgICAgICAJdGVzdCAgICVyMTRkLCVy
MTRkCiAgMmE6KgkwZiA4OCBjOSAwMCAwMCAwMCAgICAJanMgICAgIDB4ZjkJCTwtLSB0cmFw
cGluZyBpbnN0cnVjdGlvbgogIDMwOgk0OSA2MyBjZSAgICAgICAgICAgICAJbW92c2xxICVy
MTRkLCVyY3gKICAzMzoJNGMgODkgZmEgICAgICAgICAgICAgCW1vdiAgICAlcjE1LCVyZHgK
ICAzNjoJNDggMmIgNTUgYzggICAgICAgICAgCXN1YiAgICAtMHgzOCglcmJwKSwlcmR4CiAg
M2E6CTQ4IDZiIGYxIDY4ICAgICAgICAgIAlpbXVsICAgJDB4NjgsJXJjeCwlcnNpCiAgM2U6
CTQ4ICAgICAgICAgICAgICAgICAgIAlyZXguVwogIDNmOgk4ZCAgICAgICAgICAgICAgICAg
ICAJLmJ5dGUgMHg4ZAoKQ29kZSBzdGFydGluZyB3aXRoIHRoZSBmYXVsdGluZyBpbnN0cnVj
dGlvbgo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CiAgIDA6
CTBmIDg4IGM5IDAwIDAwIDAwICAgIAlqcyAgICAgMHhjZgogICA2Ogk0OSA2MyBjZSAgICAg
ICAgICAgICAJbW92c2xxICVyMTRkLCVyY3gKICAgOToJNGMgODkgZmEgICAgICAgICAgICAg
CW1vdiAgICAlcjE1LCVyZHgKICAgYzoJNDggMmIgNTUgYzggICAgICAgICAgCXN1YiAgICAt
MHgzOCglcmJwKSwlcmR4CiAgMTA6CTQ4IDZiIGYxIDY4ICAgICAgICAgIAlpbXVsICAgJDB4
NjgsJXJjeCwlcnNpCiAgMTQ6CTQ4ICAgICAgICAgICAgICAgICAgIAlyZXguVwogIDE1Ogk4
ZCAgICAgICAgICAgICAgICAgICAJLmJ5dGUgMHg4ZApbIDEwMDguNzEzMDU0XSBSU1A6IDAw
MTg6ZmZmZmM5MDAwMDEzN2U2MCBFRkxBR1M6IDAwMDAwMjA2ClsgMTAwOC43MTM2MzhdIFJB
WDogZmZmZjg4ODI1NzZlMWU4MCBSQlg6IGZmZmY4ODgyNTc2ZWE4YTAgUkNYOiAwMDAwMDAw
MDAwMDAwMDFmClsgMTAwOC43MTQyMjVdIFJEWDogMDAwMDAwMDAwMDAwMDAwMCBSU0k6IDAw
MDAwMDAwMzRlOGY5M2EgUkRJOiAwMDAwMDAwMDAwMDAwMDAwClsgMTAwOC43MTQ4OTJdIFJC
UDogZmZmZmM5MDAwMDEzN2U5OCBSMDg6IDAwMDAwMGVhZDkzN2NhNDkgUjA5OiAwMDAwMDAw
MDAwMDIxN2MwClsgMTAwOC43MTU2NDVdIFIxMDogMDAwMDAwMDAwMDAwMDAwMSBSMTE6IGZm
ZmY4ODgyNTc2ZTBmMDQgUjEyOiAwMDAwMDAwMDAwMDAwMDAzClsgMTAwOC43MTY2MTRdIFIx
MzogZmZmZmZmZmY4MjQ2MjM2MCBSMTQ6IDAwMDAwMDAwMDAwMDAwMDMgUjE1OiAwMDAwMDBl
YWQ5MzdjYTQ5ClsgMTAwOC43MTc0MTRdIGNwdWlkbGVfZW50ZXIgKGRyaXZlcnMvY3B1aWRs
ZS9jcHVpZGxlLmM6MzU4KSAKWyAxMDA4LjcxODExNl0gY2FsbF9jcHVpZGxlIChrZXJuZWwv
c2NoZWQvaWRsZS5jOjE1NikgClsgMTAwOC43MTg3MTNdIGRvX2lkbGUgKGtlcm5lbC9zY2hl
ZC9pZGxlLmM6MjQwIGtlcm5lbC9zY2hlZC9pZGxlLmM6MzAzKSAKWyAxMDA4LjcxOTI4OF0g
Y3B1X3N0YXJ0dXBfZW50cnkgKGtlcm5lbC9zY2hlZC9pZGxlLmM6Mzk5IChkaXNjcmltaW5h
dG9yIDEpKSAKWyAxMDA4LjcxOTg3NF0gc3RhcnRfc2Vjb25kYXJ5IChhcmNoL3g4Ni9rZXJu
ZWwvc21wYm9vdC5jOjI4MSkgClsgMTAwOC43MjA0NDFdIHNlY29uZGFyeV9zdGFydHVwXzY0
X25vX3ZlcmlmeSAoYXJjaC94ODYva2VybmVsL2hlYWRfNjQuUzozNTgpIApbIDEwMDguNzIx
MDA2XSAgPC9UQVNLPgpbIDEwMDguNzIxNTM5XSBNb2R1bGVzIGxpbmtlZCBpbjogc25kX2N0
bF9sZWQgc25kX3NvY19za2xfaGRhX2RzcCBzbmRfc29jX2ludGVsX2hkYV9kc3BfY29tbW9u
IHNuZF9zb2NfaGRhY19oZG1pIHNuZF9zb2ZfcHJvYmVzIHNuZF9oZGFfY29kZWNfaGRtaSBz
bmRfaGRhX2NvZGVjX3JlYWx0ZWsgc25kX2hkYV9jb2RlY19nZW5lcmljIGk5MTUgb3BlbnZz
d2l0Y2ggbWhpX3d3YW5fbWJpbSBtaGlfd3dhbl9jdHJsIHd3YW4gc25kX3NvY19kbWljIHNu
ZF9zb2ZfcGNpX2ludGVsX3RnbCBzbmRfc29mX2ludGVsX2hkYV9jb21tb24gc291bmR3aXJl
X2ludGVsIHNvdW5kd2lyZV9nZW5lcmljX2FsbG9jYXRpb24gc291bmR3aXJlX2NhZGVuY2Ug
aXdsbXZtIHNuZF9zb2ZfaW50ZWxfaGRhIHNuZF9zb2ZfcGNpIHNuZF9zb2ZfeHRlbnNhX2Rz
cCBzbmRfc29mIG1hYzgwMjExIHNuZF9zb2ZfdXRpbHMgc25kX3NvY19oZGFjX2hkYSBzbmRf
aGRhX2V4dF9jb3JlIHNuZF9zb2NfYWNwaV9pbnRlbF9tYXRjaCBzbmRfc29jX2FjcGkgc25k
X3NvY19jb3JlIGxpYmFyYzQgc25kX2NvbXByZXNzIGNkY19tYmltIGludGVsX2d0dCBzb3Vu
ZHdpcmVfYnVzIHR0bSBpd2x3aWZpIGNkY193ZG0gZHJtX2J1ZGR5IHNuZF9oZGFfaW50ZWwg
ZHJtX2Rpc3BsYXlfaGVscGVyIHNuZF9pbnRlbF9kc3BjZmcgc25kX2ludGVsX3Nkd19hY3Bp
IGRybV9rbXNfaGVscGVyIHNuZF9oZGFfY29kZWMgcHJvY2Vzc29yX3RoZXJtYWxfZGV2aWNl
X3BjaV9sZWdhY3kgbmxzX2lzbzg4NTlfMSBjZGNfbmNtIG5sc19jcDQzNyBwcm9jZXNzb3Jf
dGhlcm1hbF9kZXZpY2Ugc25kX2h3ZGVwIGNkY19ldGhlciBpbnRlbF90Y2NfY29vbGluZyB4
ODZfcGtnX3RlbXBfdGhlcm1hbCBzbmRfaGRhX2NvcmUgcHJvY2Vzc29yX3RoZXJtYWxfcmZp
bSBpbnRlbF9wb3dlcmNsYW1wIHN5c2NvcHlhcmVhIHVzYm5ldCBjZmc4MDIxMSBwcm9jZXNz
b3JfdGhlcm1hbF9tYm94IG1paSBzeXNmaWxscmVjdCBoaWRfbXVsdGl0b3VjaApbIDEwMDgu
NzIxNTg0XSAgc25kX3BjbSBjb3JldGVtcCBpbnB1dF9sZWRzIHN5c2ltZ2JsdCB0aGlua19s
bWkgaW50ZWxfcmFwbF9tc3IgbWhpX3BjaV9nZW5lcmljIGkyY19pODAxIHRoaW5rcGFkX2Fj
cGkgcHJvY2Vzc29yX3RoZXJtYWxfcmFwbCBzbmRfdGltZXIgaTJjX2Rlc2lnbndhcmVfcGxh
dGZvcm0gbWhpIGZpcm13YXJlX2F0dHJpYnV0ZXNfY2xhc3Mgc2VyaW9fcmF3IHRodW5kZXJi
b2x0IGkyY19kZXNpZ253YXJlX2NvcmUgaW50ZWxfcmFwbF9jb21tb24gbnZyYW0gZmJfc3lz
X2ZvcHMgdHBtX2NyYiBwbGF0Zm9ybV9wcm9maWxlIHVjc2lfYWNwaSBpbnQzNDAwX3RoZXJt
YWwgdHBtX3RpcyBpbnRlbF9scHNzX3BjaSB0eXBlY191Y3NpIHBpbmN0cmxfdGlnZXJsYWtl
IGxlZHRyaWdfYXVkaW8gaW50ZWxfbHBzcyBpbnQzNDAzX3RoZXJtYWwgaTJjX3NtYnVzIHJv
bGVzIHRwbV90aXNfY29yZSB2aWRlbyBtZmRfY29yZSBhY3BpX3RoZXJtYWxfcmVsIHBpbmN0
cmxfaW50ZWwgaW50ZWxfc29jX2R0c19pb3NmIGludDM0MHhfdGhlcm1hbF96b25lIHdtaSB0
ZGlzayBbbGFzdCB1bmxvYWRlZDogY3J5cHRvX3NpbWRdClsgMTAwOC43MjcyNThdIENSMjog
ZmZmZjg4ODEwMWJlNzk0Ygo=

--------------lVALqjZO6U5LtfkSh57OjJNa--
